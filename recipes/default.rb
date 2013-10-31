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
