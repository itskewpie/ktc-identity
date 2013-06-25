#
# Cookbook Name:: ktc-keystone
# Recipe:: memcache
#

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "keystone::keystone-common"

ks_admin_bind = get_bind_endpoint("keystone", "admin-api")
ks_service_bind = get_bind_endpoint("keystone", "service-api")
settings = get_settings_by_role("keystone-setup", "keystone")
mysql_info = get_access_endpoint("mysql-master", "mysql", "db")

memcached_servers = ''
memcached_endpoints = get_realserver_endpoints("memcached", "memcached", "cache")
memcached_endpoints.each do |endpoint|
  memcached_servers += "#{endpoint['host']}:#{endpoint['port']},"
end
memcached_servers = memcached_servers[0..-2]

# only bind to 0.0.0.0 if we're not using openstack-ha w/ a keystone-admin-api VIP,
# otherwise HAProxy will fail to start when trying to bind to keystone VIP
ha_role = "openstack-ha"
vip_key = "vips.keystone-admin-api"
if get_role_count(ha_role) > 0 and rcb_safe_deref(node, vip_key)
  ip_address = ks_admin_bind["host"]
else
  ip_address = "0.0.0.0"
end

# Setup db_info hash for use in the template
db_info = {
  "user" => settings["db"]["username"],
  "pass" => settings["db"]["password"],
  "name" => settings["db"]["name"],
  "ipaddress" => mysql_info["host"] }

rewind :template => "/etc/keystone/keystone.conf" do
  cookbook "ktc-keystone"
  variables(
    :debug => settings["debug"],
    :verbose => settings["verbose"],
    :db_info => db_info,
    :ip_address => ip_address,
    :service_port => ks_service_bind["port"],
    :admin_port => ks_admin_bind["port"],
    :admin_token => settings["admin_token"],
    :member_role_id => node["keystone"]["member_role_id"],
    :auth_type => settings["auth_type"],
    :ldap_options => settings["ldap"],
    :pki_token_signing => settings["pki"]["enabled"],
    :memcached_servers => memcached_servers
  )
end
