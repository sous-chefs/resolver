name              'resolver'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache-2.0'
description       'Configures /etc/resolv.conf via attributes'
version '2.1.0'

%w(aix ubuntu debian fedora centos redhat oracle scientific amazon freebsd openbsd mac_os_x solaris2 opensuse opensuseleap suse).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/resolver'
issues_url 'https://github.com/chef-cookbooks/resolver/issues'
chef_version '>= 12.15'
