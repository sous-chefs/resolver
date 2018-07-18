#
# Cookbook:: resolver
# Recipe:: default
#
# Copyright:: 2009-2017, Chef Software, Inc.
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
# = Requires
# * node[:resolver][:nameservers]

def docker_guest?
  node['virtualization'] && node['virtualization']['systems'] &&
    node['virtualization']['systems']['docker'] && node['virtualization']['systems']['docker'] == 'guest'
end

if node['resolver']['nameservers'].empty? || node['resolver']['nameservers'][0].empty?
  Chef::Log.warn("#{cookbook_name}::#{recipe_name} requires that attribute ['resolver']['nameservers'] is set.")
  Chef::Log.info("#{cookbook_name}::#{recipe_name} exiting to prevent a potential breaking change in /etc/resolv.conf.")
  return
end

if node['resolver']['search'].is_a?(Array) && (node['resolver']['search'].count > 6 || node['resolver']['search'].join.size > 256)
  Chef::Log.warn("#{cookbook_name}::#{recipe_name} attribute ['resolver']['search'] can contain no more than 6 search domains and a total of 256 characters")
  Chef::Log.warn("#{cookbook_name}::#{recipe_name} truncating resolv.conf search domain list to the first 6 entries.")
end

t = template '/etc/resolv.conf' do
  source 'resolv.conf.erb'
  owner 'root'
  group node['root_group']
  mode '0644'
  # This syntax makes the resolver sub-keys available directly
  variables node['resolver']
end
t.atomic_update false if docker_guest?
