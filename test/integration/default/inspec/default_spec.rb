describe file('/etc/resolv.conf') do
  its('content') { should match /^search localdomain/ }
  its('content') { should match /^nameserver 1\.1\.1\.1/ }
  its('content') { should match /^nameserver 8\.8\.8\.8/ }
  its('content') { should match /^options rotate timeout:2/ }
end

describe command('curl https://www.google.com') do
  its('exit_status') { should eq 0 }
end
