# set the default recipe for rabbit
default["openstack"]["identity"]["rabbit_server_chef_role"] = "ktc-messaging"
default["openstack"]["identity"]["token"]["backend"] = "memcache"
# process monitoring
default["openstack"]["identity"]["processes"] = [
  { "name" =>  "keystone-all", "shortname" =>  "keystone-all" }
]
