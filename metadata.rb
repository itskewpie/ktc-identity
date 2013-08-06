name              "ktc-identity"
maintainer        "KT Cloudware"
description	  "Installs/Configures Openstack Network Service"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.20"
recipe		  "ktc-identity::default", "Installs packages required for identity server"

%w{ centos ubuntu }.each do |os|
  supports os
end

%w{
  ktc-utils
  openstack-common
  openstack-identity
}.each do |dep|
  depends dep
end
