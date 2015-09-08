name              'resolver'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache 2.0'
description       'Configures /etc/resolv.conf via attributes'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.3.1'

recipe 'resolver', 'Configures /etc/resolv.conf via attributes'
recipe 'resolver::from_server_role', 'Manages nameservers from role with explicitly set servers'

%w(ubuntu debian fedora centos redhat oracle scientific amazon freebsd openbsd mac_os_x solaris2).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/resolver' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/resolver/issues' if respond_to?(:issues_url)

attribute 'resolver',
  :display_name => 'Resolver',
  :description => 'Hash of Resolver attributes',
  :type => 'hash'

attribute 'resolver/search',
  :display_name => 'Resolver Search',
  :description => 'Default domain to search',
  :default => 'domain'

attribute 'resolver/nameservers',
  :display_name => 'Resolver Nameservers',
  :description => 'Default nameservers',
  :type => 'array',
  :default => []

attribute 'resolver/options',
  :display_name => 'Resolver Options',
  :description => 'Default resolver options',
  :type => 'hash',
  :default => {}

attribute 'resolver/server_role',
  :display_name => 'Resolver Server Role',
  :description => 'Name of the role applied to the DNS resolver node',
  :type => 'string',
  :default => 'nameserver'
