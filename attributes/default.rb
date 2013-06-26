# memcache package
case platform
when "ubuntu"
  default["keystone"]["platform"]["memcache_python_packages"] = [ "python-memcache" ]
end
