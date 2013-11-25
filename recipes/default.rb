#
## Cookbook Name:: ktc-identity
## Recipe:: default
#

include_recipe "services"
include_recipe "ktc-utils"

iface = KTC::Network.if_lookup "management"
ip = KTC::Network.address "management"

Services::Connection.new run_context: run_context
identity_api = Services::Member.new node[:fqdn],
  service: "identity-api",
  port: 5000,
  proto: "tcp",
  ip: ip

identity_api.save

identity_admin = Services::Member.new node[:fqdn],
  service: "identity-admin",
  port: 35357,
  proto: "tcp",
  ip: ip

identity_admin.save

KTC::Attributes.set

node.default["openstack"]["identity"]["bind_interface"] = iface

include_recipe "openstack-common"
include_recipe "openstack-common::logging"
include_recipe "openstack-identity::server"
include_recipe "openstack-identity::registration"

# save so searches in other recipes can access node attrs
node.save

# process monitoring and sensu-check config
processes = node['openstack']['identity']['processes']

processes.each do |process|
  sensu_check "check_process_#{process['name']}" do
    command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process['name']}"
    handlers ["default"]
    standalone true
    interval 30
  end
end

ktc_collectd_processes "identity-processes" do
  input processes
end
