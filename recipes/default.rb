#
## Cookbook Name:: ktc-identity
## Recipe:: default
#

class Chef::Recipe
  include KTCUtils
end

d1 = get_openstack_service_template(get_interface_address("management"), "5000")
register_member("identity-api", d1)

d2 = get_openstack_service_template(get_interface_address("management"), "35357")
register_member("identity-admin", d2)

set_rabbit_servers "identity"
set_memcached_servers
set_database_servers "identity"
set_service_endpoint "identity-api"
set_service_endpoint "identity-admin"

node.default["openstack"]["identity"]["bind_interface"] = get_interface "management"

include_recipe "openstack-common"
include_recipe "openstack-common::logging"
include_recipe "openstack-identity::server"
include_recipe "openstack-identity::registration"
