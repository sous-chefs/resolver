describe file('/etc/resolv.conf') do
  it { should_not be_symlink }
  it { should be_file }
  its('content') { should match /nameserver 1.1.1.1/ }
  its('content') { should match /nameserver 1.0.0.1/ }
  its('content') { should match /domain test\.com/ }
  its('content') { should match /search test1\.com test2\.com/ }
  its('content') { should match /options timeout:2 rotate attempts:1/ }
end

describe command('curl https://www.google.com') do
  its('exit_status') { should eq 0 }
end

describe command('dig www.google.com') do
  its('stdout') { should match /SERVER: 1.1.1.1/ }
end

describe ini('/etc/NetworkManager/conf.d/90-dns-none.conf') do
  its('main.dns') { should eq 'none' }
end if os.redhat? || os.name.eql?('fedora')
