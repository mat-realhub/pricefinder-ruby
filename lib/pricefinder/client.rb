require 'faraday'
require 'faraday_middleware'

require 'pricefinder/configuration'
require 'pricefinder/error'

module Pricefinder
  class Client

    API_HOST = 'https://api.pricefinder.com.au/v1'
    USER_AGENT = "Pricefinder Ruby Wrapper #{Pricefinder::VERSION}"

    attr_reader :configuration

    def initialize(options = nil)
      @config = nil
      @retry_count = 0

      unless options.nil?
        @configuration = Configuration.new(options)
        check_valid_config
      end

      # Create Connection
      connection

      # Get Access Token
      get_access_token
    end

    def check_valid_config
      if configuration.nil? || !configuration.valid?
        @configuration = nil
        raise Error::MissingClientRequiredConfig
      end
    end

    def connection
      return @connection if instance_variable_defined?(:@connection)
      check_valid_config

      @connection = Faraday.new(API_HOST) do |faraday|
        faraday.request  :url_encoded
        faraday.headers[:user_agent] = USER_AGENT
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def access_token
      @configuration.access_token
    end

    def get(path, params = {}, options = {})
      response = @connection.get do |request|
        request.headers['Authorization'] = "Bearer #{access_token}"
        request.url path
        request.params = params
      end

      handle_response(response)
    end

    def handle_response(response)
      return response.body if response.body
      return { errors: build_errors(response) }
    end

    def build_errors(response)
      errors = []
      errors << "Unauthorized Token: #{access_token}" if response.status == 401
      errors << "Could not handle response" if response.status == 500

      return errors
    end

    def handle_unauthorized
      if @retry_count == 0
        # Get a new access token
        get_access_token(true)
        
        # Retry
        @retry_count += 1
      end
    end

    private

    def get_access_token(force_auth = false)
      config_params = @configuration.config_params
      
      # If we were passed an access token use it
      if !force_auth && token = config_params[:access_token]
        @configuration.access_token = token
        return
      end

      # We need to generate a new token but we are missing the required params
      if force_auth && (config_params[:client_id].nil? || config_params[:client_id].nil?)
        raise Error::MissingClientRequiredConfig
      end

      # Otherwise get a new token using credentials
      if (client_id = config_params[:client_id]) && (client_secret = config_params[:client_secret])
        authenticate_client_credentials(client_id, client_secret)
      end
    end
    
    def authenticate_client_credentials(client_id, client_secret)
      response = @connection.post('oauth/token', {
        :grant_type => 'client_credentials',
        :client_id => client_id,
        :client_secret => client_secret
      })

      if response.status == 200 && token = response.body["tokenKey"]
        @configuration.access_token = token
      else
        raise Error::InvalidCredentials
      end
    end

  end
end