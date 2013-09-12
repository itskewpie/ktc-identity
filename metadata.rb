name              "ktc-identity"
maintainer        "KT Cloudware"
description	  "Installs/Configures Openstack Network Service"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.20"
recipe		  "ktc-identity::default", "Installs packages required for identity server"

%w{ centos ubuntu }.each do |os|
  supports os
end

depends "ktc-utils", "~> 0.3.2"
depends "openstack-common", "~> 0.4.3"
depends "openstack-identity", "~> 7.0.0"
depends "services", "~> 1.0.6"
