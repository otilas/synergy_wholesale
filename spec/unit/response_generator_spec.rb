require 'synergy_wholesale/response_generator'

RSpec.describe SynergyWholesale::ResponseGenerator do

  describe '#build_response' do
    context 'when class exists' do
      module SynergyWholesale
        module Responses
          Foo = Struct.new(:response, :soap_command)
        end
      end

      it 'returns an instance of the response class' do
        response_generator = SynergyWholesale::ResponseGenerator.new
        expect(
          response_generator.build_response(
            'SynergyWholesale::Commands::Foo',
            'response',
            'soap_command'
          )
        ).to be_an_instance_of(::SynergyWholesale::Responses::Foo)
      end
    end

    context 'when class does not exist' do
      it 'raises an exception' do
        response_generator = SynergyWholesale::ResponseGenerator.new
        expect {
          response_generator.build_response('SynergyWholesale::Commands::Bar', 'response', 'soap_command')
        }.to raise_error(NameError, 'uninitialized constant SynergyWholesale::Responses::Bar')
      end
    end
  end

end
