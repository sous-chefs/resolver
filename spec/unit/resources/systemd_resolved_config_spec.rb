require 'spec_helper'

describe 'resolver_systemd_resolved_config' do
  step_into :resolver_systemd_resolved_config
  platform 'centos'

  context 'create a resolv config and verify config is created properly' do
    recipe do
      resolver_systemd_resolved_config '/etc/systemd/resolved.conf' do
        dns ['1.1.1.1', '1.0.0.1', '2606:4700:4700::1111', '2606:4700:4700::1001']
        fallback_dns '8.8.8.8,8.8.4.4,2001:4860:4860::8888,2001:4860:4860::8844'
        domains 'localtest.com'
      end
    end

    it 'Creates the main configuration file' do
      is_expected.to render_file('/etc/systemd/resolved.conf')
        .with_content(/DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001/)
        .with_content(/FallBackDNS=8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844/)
        .with_content(/DNSSEC=allow-downgrade/)
        .with_content(/Domains=localtest.com/)
        .with_content(/CacheFromLocalhost=no/)
    end
  end
end
