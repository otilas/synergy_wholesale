require 'synergy_wholesale/adapter'

RSpec.describe SynergyWholesale::Adapter do

  describe '#client' do
    it 'is a configured Savon client' do
      adapter = SynergyWholesale::Adapter.new
      expect(adapter.client).to be_an_instance_of(Savon::Client)
      expect(adapter.client.globals[:wsdl]).to eq 'https://api.synergywholesale.com/server.php?wsdl'
    end
  end

  describe '#params' do
    it 'defaults to having the reseller id and api key' do
      adapter = SynergyWholesale::Adapter.new
      expect(adapter.params).to eq(
                                  {
                                    'resellerID' => '123',
                                    'apiKey'     => '123'
                                  }
                                )
    end
  end

  describe '#add_param' do
    it 'modifies the params hash' do
      adapter = SynergyWholesale::Adapter.new
      expect {
        adapter.add_param('foo', 'bar')
      }.to change(adapter, :params)
    end

    it 'adds the param to the hash' do
      adapter = SynergyWholesale::Adapter.new
      adapter.add_param('foo', 'bar')
      expect(adapter.params['foo']).to eq 'bar'
    end
  end

  describe '#add_params' do
    context 'when no params are sent' do
      it 'no-ops' do
        adapter = SynergyWholesale::Adapter.new
        expect {
          adapter.add_params
        }.not_to change(adapter, :params)
      end
    end

    context 'when non-hash values are sent' do
      it 'raises an exception' do
        adapter = SynergyWholesale::Adapter.new
        expect {
          adapter.add_params('foo', 'bar')
        }.to raise_error(Exception, 'params are required to be key/value combinations')
      end
    end

    context 'when a hash is sent' do
      it 'modifies the params hash' do
        adapter = SynergyWholesale::Adapter.new
        expect {
          adapter.add_params(foo: 'bar')
        }.to change(adapter, :params)
      end

      it 'merges the params into the hash' do
        adapter = SynergyWholesale::Adapter.new
        adapter.add_params(foo: 'bar', bar: 'baz')
        expect(adapter.params[:foo]).to eq 'bar'
        expect(adapter.params[:bar]).to eq 'baz'
        expect(adapter.params['resellerID']).to eq '123'
      end
    end
  end

  describe '#call' do
    it 'delegates to the client, passing in required params' do
      adapter = SynergyWholesale::Adapter.new
      client  = instance_spy('Savon::Client')
      adapter.instance_variable_set(:'@client', client)

      adapter.call(:foo)

      expect(client).to have_received(:call).with(
        :foo,
        message: {
          request: {
            'resellerID' => '123',
            'apiKey'     => '123'
          }
        }
      )
    end
  end

end
