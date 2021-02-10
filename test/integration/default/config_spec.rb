describe file('/etc/resolv.conf') do
  its('content') { should match /nameserver 1.1.1.1/ }
  its('content') { should match /nameserver 1.0.0.1/ }
  its('content') { should match /domain test\.com/ }
  its('content') { should match /search test1\.com test2\.com/ }
  its('content') { should match /options timeout:2/ }
end

describe command('curl https://www.google.com') do
  its('exit_status') { should eq 0 }
end

describe file('/etc/NetworkManager/conf.d/90-dns-none.conf') do
  its('content') { should match /[main]/ }
  its('content') { should match /dns=none/ }
end
