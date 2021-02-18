module Resolver
  module Cookbook
    module TemplateHelpers
      def nil_or_empty?(property)
        property.nil? || (property.respond_to?(:empty?) && property.empty?)
      end

      def systemd_value(value)
        case value
        when true
          'yes'
        when false
          'no'
        else
          value
        end
      end
    end
  end
end
