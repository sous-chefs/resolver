# frozen_string_literal: true

require 'pathname'

module Resolver
  module Cookbook
    module Helpers
      RESOLVER_RESOLV_CONF_DEFAULT = '/etc/resolv.conf'
      RESOLVER_RESOLVED_CONF_DEFAULT = '/etc/systemd/resolved.conf'
      RESOLVER_CONF_USER_DEFAULT = 'root'

      def resolver_conf_group_default
        node['root_group']
      end

      def resolver_override_default(file)
        return false if Pathname.new(file).mountpoint?

        true
      end
    end
  end
end
