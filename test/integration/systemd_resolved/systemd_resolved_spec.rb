describe file('/etc/systemd/resolved.conf') do
  its('content') { should match /DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001/ }
  its('content') { should match /FallBackDNS=8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844/ }
  its('content') { should match /DNSSEC=allow-downgrade/ }
  its('content') { should match /Domains=localtest.com/ }
  its('content') { should match /CacheFromLocalhost=no/ }
end

describe command('curl https://www.google.com') do
  its('exit_status') { should eq 0 }
end

describe command('dig www.google.com') do
  its('stdout') { should match /SERVER: 127.0.0.\d{1,3}/ }
end

describe service('systemd-resolved') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
