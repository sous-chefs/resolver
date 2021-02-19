resolver_config '/etc/resolv.conf' do
  nameservers ['1.1.1.1', '1.0.0.1']
  domain 'test.com'
  search ['test1.com', 'test2.com']
  options(
    'timeout' => 2,
    'rotate' => nil,
    'attempts' => 1
  )
  override_system_configuration true
end
