require 'spec_helper'

describe Pricefinder::Client do
  include_context 'shared configuration'

  VCR.insert_cassette('authentication', :allow_playback_repeats => true)

  let(:client_config) { valid_config }
  let(:client) { Pricefinder::Client.new(client_config) }

  describe '#initialize' do
    subject { client }

    context 'with client credentials' do

      it 'should be the correct class' do
        expect(client.configuration).to be_a Pricefinder::Configuration
      end

      it 'should create a new connection' do
        expect(client.connection).to be_a Faraday::Connection
      end

      it 'should have an access_token' do
        expect(client.access_token).to be_a String
      end
    end

    context 'with access_token' do
      let(:client) { Pricefinder::Client.new({ access_token: 'token' }) }

      it 'should be the correct class' do
        expect(client.configuration).to be_a Pricefinder::Configuration
      end
    end
  end

  describe '#connection' do
    let(:client) { Pricefinder::Client.new }

    context 'without configuration' do
      it 'should raise an error' do
        expect { client.connection }.to raise_error(Pricefinder::Error::MissingClientRequiredConfig)
      end
    end
  end

end