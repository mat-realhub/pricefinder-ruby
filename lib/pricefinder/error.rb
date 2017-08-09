module Pricefinder
  module Error
    class ResponseValidator

      def validate(response)
        return if successful_response?(response)
      end

      private

      def successful_response?(response)
        (200..399).include?(response.status)
      end
    end

    class Base < StandardError
      def initialize(msg,error=nil)
        super(msg)
      end
    end

    class AlreadyConfigured < Base
      def initialize(msg = 'Gem cannot be reconfigured.  Initialize a new ' +
          'instance of Pricefinder::Client.', error=nil)
        super
      end
    end

    class InvalidCredentials < Base
      def initialize(msg = "Invalid client_id or client_secret.", error=nil)
        super
      end
    end

    class MissingClientRequiredConfig < Base
      def initialize(msg = "Missing required client config", error=nil)
        super
      end
    end
  end
end
