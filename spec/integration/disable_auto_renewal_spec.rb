require 'savon/mock/spec_helper'

module SynergyWholesale
  RSpec.describe DisableAutoRenewal do
    include Savon::SpecHelper

    # set Savon in and out of mock mode
    before(:all) { savon.mock! }
    after(:all) { savon.unmock! }

    def message(params)
      core_params = API.new.adapter.params
      { request: core_params.merge(params) }
    end

    describe 'EnableAutoRenewal' do
      context 'when disabling succeeds' do

        it 'is enabled' do
          fixture = File.read('spec/fixtures/synergy/domain/autorenew/disable/success.xml')

          savon
            .expects(:disable_auto_renewal)
            .with(message: message({ domain_name: 'bobsburgers.com.au' }))
            .returns(fixture)

          expect(DisableAutoRenewal.call(domain: { name: 'bobsburgers.com.au' }).is_enabled?).to be_falsey
        end

      end

      context 'when disabling is not allowed' do

        it 'raises a response error' do
          fixture = File.read('spec/fixtures/synergy/domain/autorenew/disable/failure.xml')

          savon
            .expects(:disable_auto_renewal)
            .with(message: message({ domain_name: 'google.com' }))
            .returns(fixture)

          expect {
            DisableAutoRenewal.call(domain: { name: 'google.com' })
          }.to raise_error(Errors::ResponseError, 'Reseller is not authorized to perform any functions on this domain')
        end

      end

    end

  end
end
