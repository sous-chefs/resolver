module Resolver
  module Cookbook
    module TemplateHelpers
      def nil_or_empty?(property)
        property.nil? || (property.respond_to?(:empty?) && property.empty?)
      end
    end
  end
end
