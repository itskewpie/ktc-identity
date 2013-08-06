#
## Cookbook Name:: ktc-identity
## Recipe:: default
#

class Chef::Recipe
  include KTCUtils
end

set_rabbit_servers "identity"
set_memcached_servers
set_database_servers "identity"
set_service_endpoint_ip "identity-api"
set_service_endpoint_ip "identity-admin"
node.default["openstack"]["identity"]["bind_interface"] = get_interface "management"

include_recipe "openstack-common"
include_recipe "openstack-common::logging"
include_recipe "openstack-identity::server"
include_recipe "openstack-identity::registration"
