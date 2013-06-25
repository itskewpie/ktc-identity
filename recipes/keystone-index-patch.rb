# Cookbook Name:: ktc-keystone
# Recipe:: keystone-index-patch
#
# Copyright 2012, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "osops-utils"

if ::Chef::Recipe::Patch.check_package_version("keystone","1:2013.1.1-0ubuntu2~cloud0", node)
  template "/usr/share/pyshared/keystone/common/sql/migrate_repo/versions/024_add_index_to_expires.py" do
    source "patches/024_add_index_to_expires.py.1:2013.1.1-0ubuntu2~cloud0"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, "service[keystone]", :immediately
  end

  template "/usr/share/pyshared/keystone/common/sql/migrate_repo/versions/025_add_index_to_valid.py" do
    source "patches/025_add_index_to_valid.py.1:2013.1.1-0ubuntu2~cloud0"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, "service[keystone]", :immediately
  end
end
