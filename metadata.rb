name 'resolver'
maintainer 'Opscode, Inc.'
maintainer_email 'cookbooks@opscode.com'
license 'Apache 2.0'
description 'Configures /etc/resolv.conf via attributes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.0'

recipe 'resolver', 'Configures /etc/resolv.conf via attributes'
recipe 'resolver::from_server_role', 'Manages nameservers from role with
  explicitly set servers'

%w( ubuntu debian fedora centos redhat freebsd openbsd macosx \
    solaris ).each do |os|
  supports os
end
