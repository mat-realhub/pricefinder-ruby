module Pricefinder
  class Client
    
    attr_reader :configuration

    # Creates an instance of the Pricefinder Client
    # @params options [Hash, nil] a hash of the client_id, client_secret
    # @return [Client] a new client initialized using the params provided
    #
    # @example Basic Usage
    # Pricefinder::Client.new({ 
    #   client_id: 'username',
    #   client_secret: 'password'
    # })
    #
    def initialize(options = nil)
      @config = nil

      unless options.nil?
        @configuration = Configuration.new(options)
        check_required_params
      end
    end

    # Check that all required params were supplied
    def check_required_params
      if configuration.nil? || !configuration.valid?
        @configuration = nil
        raise Error::MissingClientRequiredParams
      else
        # Freeze the configuration so it cannot be modified once the 
        # gem is configured.
        @configuration.freeze
      end
    end

    # API connection
    def connection
      return @connection if instance_variable_defined?(:@connection)

      check_required_params
      @connection = Faraday.new(@api_base) do |faraday|
        # Use the Faraday OAuth middleware for OAuth requests
        faraday.request :oauth, @configuration.config_params
        faraday.adapter Faraday.default_adapter
      end
    end

  end
end