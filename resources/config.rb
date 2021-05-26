#
# Cookbook:: resolver
# Resource:: config
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

unified_mode true

include Resolver::Cookbook::Helpers

property :config_file, String,
          default: lazy { RESOLVER_RESOLV_CONF_DEFAULT },
          description: 'The path to the resolver configuration file on disk'

property :cookbook, String,
          default: 'resolver',
          description: 'Template source cookbook'

property :template, String,
          default: 'resolv.conf.erb',
          description: 'Template source file'

property :owner, String,
          default: lazy { RESOLVER_CONF_USER_DEFAULT },
          description: 'Generated file owner'

property :group, String,
          default: lazy { resolver_conf_group_default },
          description: 'Generated file group'

property :mode, String,
          default: '0644',
          description: 'Generated file mode'

property :nameservers, [String, Array],
          coerce: proc { |p| p.is_a?(String) ? p.split(',') : p },
          required: true,
          description: 'The DNS servers to configure for system name resolution'

property :domain, String,
          description: 'The DNS domain name for the host'

property :search, [String, Array],
          coerce: proc { |p| p.is_a?(String) ? p.split(',') : p },
          description: 'The DNS domain search list for the host',
          callbacks: {
            'with glibc < 2.26 the number of search domains are limited to 6' => lambda { |p|
              p.count <= 6 || (node['languages']['c']['glibc']['version'].to_f >= 2.26)
            },
            'with glibc < 2.26 the total length of the search list is limited to 256 character' => lambda { |p|
              p.join(' ').length <= 256 || (node['languages']['c']['glibc']['version'].to_f >= 2.26)
            },
          }

property :sortlist, [String, Array],
          coerce: proc { |p| p.is_a?(Array) ? p : [p] },
          description: 'The DNS sort list for the host'

property :options, Hash,
          description: 'Additional options to add to the resolver configuration file'

property :override_system_configuration, [true, false],
          default: lazy { resolver_override_default(config_file) },
          description: 'Override the system DNS configuration, for use with NetworkManager/resolvconf/systemd-resolved'

action :set do
  if new_resource.override_system_configuration
    directory '/etc/NetworkManager/conf.d' do
      recursive true
    end

    template '/etc/NetworkManager/conf.d/90-dns-none.conf' do
      cookbook new_resource.cookbook
      source '90-dns-none.conf.erb'

      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode

      action :create
    end if ::Dir.exist?('/etc/NetworkManager')
  end

  template new_resource.config_file do
    cookbook new_resource.cookbook
    source new_resource.template

    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode

    force_unlink new_resource.override_system_configuration
    manage_symlink_source !new_resource.override_system_configuration

    variables(
      nameservers: new_resource.nameservers,
      domain: new_resource.domain,
      search: new_resource.search,
      sortlist: new_resource.sortlist,
      options: new_resource.options
    )
    helpers(Resolver::Cookbook::TemplateHelpers)

    action :create
  end
end
