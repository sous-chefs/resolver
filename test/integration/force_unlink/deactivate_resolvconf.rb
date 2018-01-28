describe file('/etc/resolv.conf') do
  it { should be_file }
  it { should_not be_symlink }
end
