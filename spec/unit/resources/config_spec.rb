require 'spec_helper'

describe 'resolver_config' do
  step_into :resolver_config
  platform 'centos'

  context 'create a resolv config and verify config is created properly' do
    recipe do
      resolver_config '/etc/resolv.conf' do
        nameservers ['1.1.1.1', '1.0.0.1']
        domain 'test.com'
        search ['test1.com', 'test2.com']
        options(
          'timeout' => 2,
          'rotate' => nil,
          'attempts' => 1
        )
      end
    end

    it 'Creates the main configuration file' do
      is_expected.to render_file('/etc/resolv.conf')
        .with_content(/nameserver 1.1.1.1/)
        .with_content(/nameserver 1.0.0.1/)
        .with_content(/domain test\.com/)
        .with_content(/search test1\.com test2\.com/)
        .with_content(/options timeout:2 rotate attempts:1/)
    end
  end
end
