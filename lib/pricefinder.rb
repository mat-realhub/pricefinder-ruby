# Pricefinder Ruby
# API Spec at https://api.pricefinder.com.au/v1/swagger/index.html

require 'pricefinder/client'
require 'pricefinder/utilities'
require 'pricefinder/version'

module Pricefinder

  def self.client
    @client ||= Pricefinder::Client.new
  end
end
