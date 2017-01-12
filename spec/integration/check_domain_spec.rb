require 'savon/mock/spec_helper'

module SynergyWholesale
  RSpec.describe CheckDomain do
    include Savon::SpecHelper

    # set Savon in and out of mock mode
    before(:all) { savon.mock! }
    after(:all) { savon.unmock! }

    def message(params)
      core_params = API.new.adapter.params
      { request: core_params.merge(params) }
    end

    describe 'CheckDomain' do
      context 'when domain is not available' do

        it 'is falsey' do
          fixture = File.read('spec/fixtures/synergy/domain/available/example.com.xml')

          savon
            .expects(:check_domain)
            .with(message: message({ domain_name: 'example.com' }))
            .returns(fixture)

          expect(CheckDomain.call(domain: { name: 'example.com'}).is_available?).to be_falsey
        end

      end

      context 'when domain is available' do

        it 'is truthy' do
          fixture = File.read('spec/fixtures/synergy/domain/available/ljsdlksdlfkmsldlskmlskmdlfkjlskjdlmlknlks.com.xml')

          savon
            .expects(:check_domain)
            .with(message: message({ domain_name: 'ljsdlksdlfkmsldlskmlskmdlfkjlskjdlmlknlks.com' }))
            .returns(fixture)

          expect(CheckDomain.call(domain: { name: 'ljsdlksdlfkmsldlskmlskmdlfkjlskjdlmlknlks.com'}).is_available?).to be_truthy
        end

      end

    end

  end
end
