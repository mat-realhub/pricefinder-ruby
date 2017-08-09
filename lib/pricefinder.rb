# Pricefinder Ruby
# API Spec at https://api.pricefinder.com.au/v1/swagger/index.html

require 'pricefinder/version'
require 'pricefinder/client'

module Pricefinder

  def self.client
    @client ||= Pricefinder::Client.new
  end
end
