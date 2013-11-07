# set the default recipe for rabbit
default["openstack"]["identity"]["rabbit_server_chef_role"] = "ktc-messaging"

# process monitoring
default["openstack"]["identity"]["processes"] = [
  { "name" =>  "keystone-all", "shortname" =>  "keystone-all" }
]
