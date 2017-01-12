require 'synergy_wholesale/api'

RSpec.describe SynergyWholesale::API do

  describe '#call' do
    context 'when the response class exists' do
      module SynergyWholesale
        class Foo < Operation
          Command = Struct.new(:foo) do
            def to_param
              { foo: foo }
            end
            def operation
              :foo
            end
          end
          Response = Struct.new(:response, :soap_command)
        end
      end

      it 'adds params to the adapter' do
        adapter     = instance_spy('SynergyWholesale::Adapter', call: double('response', body: { foo_response: {} }))
        api         = SynergyWholesale::API.new
        api.adapter = adapter
        api.call(SynergyWholesale::Foo::Command.new(:foo))

        expect(adapter).to have_received(:add_params).with({ foo: :foo })
      end

      it 'returns a response object' do
        adapter     = instance_spy('SynergyWholesale::Adapter', call: double('response', body: { foo_response: {} }))
        api         = SynergyWholesale::API.new
        api.adapter = adapter
        response    = api.call(SynergyWholesale::Foo::Command.new(:foo))

        expect(response).to be_an_instance_of(SynergyWholesale::Foo::Response)
      end
    end

  end

end
