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
          default: lazy { RESOLVER_RESOLVED_CONF_DEFAULT },
          description: 'The path to the systemd-resolved configuration file on disk'

property :cookbook, String,
          default: 'resolver',
          description: 'Template source cookbook'

property :template, String,
          default: 'resolved.conf.erb',
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

property :dns, [String, Array],
          coerce: proc { |p| p.is_a?(String) ? p.split(',').each(&:strip) : p },
          required: true,
          description: 'A list of IPv4 and IPv6 addresses to use as system DNS servers'

property :fallback_dns, [String, Array],
          coerce: proc { |p| p.is_a?(String) ? p.split(',').each(&:strip) : p },
          description: 'A list of IPv4 and IPv6 addresses to use as fallback DNS servers'

property :domains, [String, Array],
          coerce: proc { |p| p.is_a?(String) ? p.split(',').each(&:strip) : p },
          description: 'A list of DNS search domains for the host'

property :llmnr, [true, false, String],
          coerce: proc { |p| p.is_a?(String) ? p.downcase : p },
          equal_to: [true, false, 'resolve'],
          description: 'Control Link-Local Multicast Name Resolution support (RFC 4795) on the host'

property :multicast_dns, [true, false, String],
          coerce: proc { |p| p.is_a?(String) ? p.downcase : p },
          equal_to: [true, false, 'resolve'],
          description: 'Control Multicast DNS support (RFC 6762) on the host'

property :dnssec, [true, false, String],
          coerce: proc { |p| p.is_a?(String) ? p.downcase : p },
          default: 'allow-downgrade',
          equal_to: [true, false, 'allow-downgrade'],
          description: 'Control DNSSEC validation on the host'

property :dns_over_tls, [true, false, String],
          coerce: proc { |p| p.is_a?(String) ? p.downcase : p },
          default: false,
          equal_to: [true, false, 'opportunistic'],
          description: 'Control DNS-over-TLS on the host'

property :cache, [true, false, String],
          coerce: proc { |p| p.is_a?(String) ? p.downcase : p },
          default: true,
          equal_to: [true, false, 'no-negative'],
          description: 'Control DNS caching on the host'

property :cache_from_localhost, [true, false],
          default: false,
          description: 'Control DNS caching of a result from a local address on the host'

property :dns_stub_listener, [true, false, String],
          coerce: proc { |p| p.is_a?(String) ? p.downcase : p },
          equal_to: [true, false, 'udp', 'tcp'],
          description: 'Control the DNS stub listener on the host'

property :dns_stub_listener_extra, [String, Array],
          coerce: proc { |p| p.is_a?(String) ? p.split(',') : p },
          description: 'Additional DNS stub sockets to listen on for the host'

property :read_etc_hosts, [true, false],
          default: true,
          description: 'Control resolution of a hostname from the /etc/hosts file'

property :resolve_unicast_single_label, [true, false],
          default: false,
          description: 'Control resolution of A and AAAA queries for single-label names over classic DNS'

action :set do
  template new_resource.config_file do
    cookbook new_resource.cookbook
    source new_resource.template

    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode

    variables(
      dns: new_resource.dns,
      fallbackdns: new_resource.fallback_dns,
      domains: new_resource.domains,
      llmnr: new_resource.llmnr,
      multicastdns: new_resource.multicast_dns,
      dnssec: new_resource.dnssec,
      dnsovertls: new_resource.dns_over_tls,
      cache: new_resource.cache,
      cachefromlocalhost: new_resource.cache_from_localhost,
      dnsstublistener: new_resource.dns_stub_listener,
      dnsstublistenerextra: new_resource.dns_stub_listener_extra,
      readetchosts: new_resource.read_etc_hosts,
      resolveunicastsinglelabel: new_resource.resolve_unicast_single_label
    )
    helpers(Resolver::Cookbook::TemplateHelpers)

    notifies :restart, 'service[systemd-resolved]', :delayed

    action :create
  end

  service 'systemd-resolved' do
    action :nothing
  end
end
