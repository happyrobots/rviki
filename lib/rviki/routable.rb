# encoding: utf-8
module RViki
  module Routable
    def self.included(base)
      base.send :include, HTTParty
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def routes
        @routes ||= {}
      end

      def route_get(route_pattern, args)
        param_keys = route_pattern.scan(/:\w+/).map { |key| key[1..-1].to_sym }
        api_name = args[:as]
        routes[api_name] = [ route_pattern, param_keys ]

        define_method(api_name) do |params={}|
          request_path = route_pattern.dup
          param_keys.each do |param_key|
            if (value = params[param_key])
              request_path.gsub!(":#{param_key}", value.to_s)
              params.delete(param_key)
            end
          end
          self.class.get(request_path, query: params)
        end
      end
    end
  end
end

