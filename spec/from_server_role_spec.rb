require 'spec_helper'

describe 'resolver::from_server_role' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node, server|
      server.create_environment('development')
      [1, 2].each do |n|
        node = stub_node("node_#{n}.example.com", ohai: { fqdn: "node_#{n}.example.com", ipaddress: "10.0.0.#{n}" }) do |test_node|
          test_node.run_list 'role[nameserver]'
        end
        server.create_node(node)
      end
    end.converge(described_recipe)
  end

  it 'populates resolv.conf with name servers' do
    expect(chef_run).to render_file('/etc/resolv.conf').with_content('nameserver 10.0.0.1')
  end
end
