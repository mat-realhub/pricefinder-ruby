shared_context "shared configuration" do

  let(:valid_config) {
    Hash[
      client_id: 'pricefinder',
      client_secret: 'password',
    ]
  }

  let(:real_config) {
    Hash[
      client_id: ENV['PRICEFINDER_CLIENT_ID'],
      client_secret: ENV['PRICEFINDER_CLIENT_SECRET'],
    ]
  }

  let(:invalid_config) {
    valid_config.merge(client_id: nil)
  }

end