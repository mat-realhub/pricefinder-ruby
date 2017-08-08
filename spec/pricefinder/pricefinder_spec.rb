require 'spec_helper'

describe Pricefinder do
  describe '::client' do
    subject { Pricefinder.client }

    it { is_expected.to be_a Pricefinder::Client }
    its(:configuration) { is_expected.to be nil }
  end
end