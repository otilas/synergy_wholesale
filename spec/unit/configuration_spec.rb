require 'synergy_wholesale/configuration'

RSpec.describe SynergyWholesale::Configuration do

  class Dummy
    extend SynergyWholesale::Configuration
  end

  before(:each) do
    Dummy.api_key     = nil
    Dummy.reseller_id = nil
  end

  describe '.reseller_id' do
    context 'when not set' do
      it 'raises an exception' do
        expect { Dummy.reseller_id }.to raise_error(Exception, 'You need to provide a reseller ID to use the Synergy Wholesale API')
      end
    end

    context 'when set' do
      it 'returns the reseller id' do
        Dummy.reseller_id = '123'
        expect(Dummy.reseller_id).to eq '123'
      end
    end
  end

  describe '.api_key' do
    context 'when not set' do
      it 'raises an exception' do
        expect { Dummy.api_key }.to raise_error(Exception, 'You need to provide an API Key to use the Synergy Wholesale API')
      end
    end

    context 'when set' do
      it 'returns the api key' do
        Dummy.api_key = '123'
        expect(Dummy.api_key).to eq '123'
      end
    end
  end

end
