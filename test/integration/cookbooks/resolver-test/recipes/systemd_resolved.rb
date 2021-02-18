resolver_systemd_resolved_config '/etc/systemd/resolved.conf' do
  dns ['1.1.1.1', '1.0.0.1', '2606:4700:4700::1111', '2606:4700:4700::1001']
  fallback_dns '8.8.8.8,8.8.4.4,2001:4860:4860::8888,2001:4860:4860::8844'
  domains 'localtest.com'
end

service 'systemd-resolved' do
  action [:enable, :start]
end
