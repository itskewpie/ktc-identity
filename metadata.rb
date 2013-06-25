name							"ktc-keystone"
maintainer        "KT Cloudware"
version           "1.0.20"
recipe            "ktc-keystone::keystone-index-patch", ""

%w{ centos ubuntu }.each do |os|
  supports os
end

%w{ keystone osops-utils }.each do |dep|
  depends dep
end
