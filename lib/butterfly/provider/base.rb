require "httparty"
require "active_support/core_ext/class/inheritable_attributes"

module Butterfly
  module Provider
    class Base

      include ::HTTParty

      class_inheritable_array :required_parameters

      def initialize(parameters = {})
        self.class.required_parameters.each do |parameter|
          self.send("#{parameter}=", parameters[parameter])
        end
      end

      private

        def self.required_parameter(*parameters)
          self.required_parameters ||= []
          self.required_parameters += parameters

          parameters.each do |parameter|
            self.send(:attr_accessor, parameter)
          end
        end

    end
  end
end