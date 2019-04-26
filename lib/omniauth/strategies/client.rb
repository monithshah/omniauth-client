require 'omniauth/strategies/oauth2'
require 'uri'

module OmniAuth
  module Strategies
    class Client < OmniAuth::Strategies::OAuth2
      # class NoAuthorizationCodeError < StandardError; en
      DEFAULT_SCOPE = 'public'

      #OATUH2_PROVIDER_URL = "https://www.elitmus.com"
      option :name, :client

      option :authorize_options, [:scope, :auth_type]

      uid {  raw_info['id']  }

      info do
        prune!({
          'email' => raw_info['email'],
          'name' => raw_info['name']
         })
      end

      extra do
        hash = {}
            hash['raw_info'] = raw_info unless skip_info?
            prune! hash
      end

      def raw_info
        @raw_info || access_token.get(api_path).parsed
      end

      def authorize_params
        super.tap do |params|
          %w[scope auth_type].each do |v|
              if request.params[v]
                params[v.to_sym] = request.params[v]
              end
          end
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      def callback_path
        options[:callback_path] || super
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
            end
      end

      def api_path
        options[:api_path] || super
      end
    end
  end
end
