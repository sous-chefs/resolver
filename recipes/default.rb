#
# Cookbook Name:: resolver
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

if node['resolver']['nameservers'].empty? || node['resolver']['nameservers'][0].empty?
  Chef::Log.warn("#{cookbook_name}::#{recipe_name} requires that attribute ['resolver']['nameservers'] is set.")
  Chef::Log.info("#{cookbook_name}::#{recipe_name} will exit to prevent a potential problem on dns resolution.")
  return
else
  case node['os']
  when 'linux'
    template "/etc/resolv.conf" do
      source "resolv.conf.erb"
      owner "root"
      group "root"
      mode 0644
      # This syntax makes the resolver sub-keys available directly
      variables node['resolver']
    end
  when 'windows'
    node['network']['interfaces'].each do |iface, vals|
      node['resolver']['nameservers'].to_enum.with_index(1) do |nameserver, index|
        execute 'Change DNS resolver configuration' do
          command "netsh interface ip set dns name=\"#{vals['instance']['net_connection_id']}\" source=static addr=#{nameserver} register=primary" if index == 1
          command "netsh interface ip add dns name=\"#{vals['instance']['net_connection_id']}\" addr=#{nameserver} index=#{index}" if index != 1
        end
      end
    end
    if not node['resolver']['search'].empty?
      registry_key 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\TCPIP\Parameters\SearchList' do
        action :delete_key
      end
      registry_key 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\TCPIP\Parameters' do
        values [{
            :name => "SearchList",
            :type =>  :string,
            :data => node['resolver']['search'].split(' ').join(',')
        }]
        action :create
      end
    end
  end
end
