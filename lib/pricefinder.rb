# Pricefinder Ruby
# API Spec at https://api.pricefinder.com.au/v1/swagger/index.html

# Version
require 'pricefinder/version'

# Support Classes
require 'pricefinder/utilities'

# API Resources


module Pricefinder
  @api_base = 'https://api.pricefinder.com.au'

  def self.client
    @client ||= Pricefinder::Client.new
  end
end
