default['resolver']['search'] = domain
default['resolver']['nameservers'] = []
default['resolver']['options'] = {}
default['resolver']['server_role'] = 'nameserver'
case platform
when "ubuntu"
  if platform_version.to_f <= 12.04
    # append to the tail of resolvconf's generated files
    default['resolver']['config_file'] = '/etc/resolvconf/resolv.conf.d/tail'
  else
    default['resolver']['config_file'] = '/etc/resolv.conf'
  end
else
  default['resolver']['config_file'] = '/etc/resolv.conf'
end
