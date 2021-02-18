dig_pkg = case node['platform_family']
          when 'rhel', 'fedora', 'amazon', 'suse'
            'bind-utils'
          when 'debian'
            'dnsutils'
          when 'freebsd'
            'bind-tools'
          end

execute 'pkg update -f' do
  action :run
end if platform_family?('freebsd')

package dig_pkg unless dig_pkg.nil?
