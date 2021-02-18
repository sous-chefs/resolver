require 'pathname'

module Resolver
  module Cookbook
    module Helpers
      RESOLVER_RESOLV_CONF_DEFAULT = '/etc/resolv.conf'.freeze
      RESOLVER_RESOLVED_CONF_DEFAULT = '/etc/systemd/resolved.conf'.freeze
      RESOLVER_CONF_USER_DEFAULT = 'root'.freeze

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
