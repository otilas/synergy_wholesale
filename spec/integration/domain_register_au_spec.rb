require 'savon/mock/spec_helper'

module SynergyWholesale

  RSpec.describe DomainRegisterAu do
    include Savon::SpecHelper

    # set Savon in and out of mock mode
    before(:all) { savon.mock! }
    after(:all) { savon.unmock! }

    def message(params)
      core_params = API.new.adapter.params
      { request: core_params.merge(params) }
    end

    describe 'DomainRegisterAu' do
      context 'with valid parameters' do

        it 'registers the domain' do
          fixture = File.read('spec/fixtures/synergy/domain/register/au/success.xml')

          domain             = { name: 'bobsburgers.com.au' }
          years              = { years: 2 }
          name_servers       = { domain_list: %w(ns1.myld.com.au ns2.myld.com.au) }
          registrant_contact = {
            firstname:    'Bob',
            lastname:     'Belcher',
            organisation: "Bob's Burgers",
            address:      ['123 Ocean Avenue'],
            suburb:       "Seymour's Bay",
            state:        'QLD',
            country:      'AU',
            postcode:     '4123',
            phone:        '+61.0751234567',
            email:        'bob@bobsburgers.com.au',
            type:         :registrant
          }
          technical_contact  = {
            firstname:    'Bob',
            lastname:     'Belcher',
            organisation: "Bob's Burgers",
            address:      ['123 Ocean Avenue'],
            suburb:       "Seymour's Bay",
            state:        'QLD',
            country:      'AU',
            postcode:     '4123',
            phone:        '+61.0751234567',
            email:        'bob@bobsburgers.com.au',
            type:         :technical
          }
          registrant         = {
            registrant_name:     "Bob's Burgers Pty Ltd",
            registrant_id:       '12345678912',
            registrant_id_type:  'ABN',
            eligibility_type:    'Company',
            eligibility_name:    "Bob's Burgers Pty Ltd",
            eligibility_id_type: 'ABN',
            eligibility_id:      '12345678912'
          }

          attributes = {
            domain:             domain,
            years:              years,
            name_servers:       Types::DomainList.build(name_servers),
            registrant_contact: Types::AuContact.build(registrant_contact),
            technical_contact:  Types::AuContact.build(technical_contact),
            registrant:         Types::AuRegistrant.build(registrant)
          }

          savon
            .expects(:domain_register_au)
            .with(
              message: message(
                         {
                           domain_name:              'bobsburgers.com.au',
                           years:                    '2',
                           name_servers:             { item: %w(ns1.myld.com.au ns2.myld.com.au), '@xsi:type' => 'enc:Array' },
                           'registrant_lastname'     => 'Belcher',
                           'registrant_firstname'    => 'Bob',
                           'registrant_organisation' => "Bob's Burgers",
                           'registrant_address'      => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'registrant_suburb'       => "Seymour's Bay",
                           'registrant_state'        => 'QLD',
                           'registrant_country'      => 'AU',
                           'registrant_postcode'     => '4123',
                           'registrant_phone'        => '+61.0751234567',
                           'registrant_fax'          => '',
                           'registrant_email'        => 'bob@bobsburgers.com.au',
                           'technical_lastname'      => 'Belcher',
                           'technical_firstname'     => 'Bob',
                           'technical_organisation'  => "Bob's Burgers",
                           'technical_address'       => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'technical_suburb'        => "Seymour's Bay",
                           'technical_state'         => 'QLD',
                           'technical_country'       => 'AU',
                           'technical_postcode'      => '4123',
                           'technical_phone'         => '+61.0751234567',
                           'technical_fax'           => '',
                           'technical_email'         => 'bob@bobsburgers.com.au',
                           'registrantName'          => "Bob's Burgers Pty Ltd",
                           'registrantID'            => '12345678912',
                           'registrantIDType'        => 'ABN',
                           'eligibilityID'           => '12345678912',
                           'eligibilityIDType'       => 'ABN',
                           'eligibilityName'         => "Bob's Burgers Pty Ltd",
                           'eligibilityType'         => 'Company'
                         }
                       )
            )
            .returns(fixture)


          expect(DomainRegisterAu.call(attributes)).to be_successful
        end

      end

      context 'with invalid parameters' do

        it 'returns an error' do
          fixture = File.read('spec/fixtures/synergy/domain/register/au/failure.xml')

          domain             = { name: 'localsearch.com.au' }
          years              = { years: 2 }
          name_servers       = { domain_list: %w(ns1.myld.com.au ns2.myld.com.au) }
          registrant_contact = {
            firstname:    'Bob',
            lastname:     'Belcher',
            organisation: "Bob's Burgers",
            address:      ['123 Ocean Avenue'],
            suburb:       "Seymour's Bay",
            state:        'QLD',
            country:      'AU',
            postcode:     '4123',
            phone:        '+61.0751234567',
            email:        'bob@bobsburgers.com.au',
            type:         :registrant
          }
          technical_contact  = {
            firstname:    'Bob',
            lastname:     'Belcher',
            organisation: "Bob's Burgers",
            address:      ['123 Ocean Avenue'],
            suburb:       "Seymour's Bay",
            state:        'QLD',
            country:      'AU',
            postcode:     '4123',
            phone:        '+61.0751234567',
            email:        'bob@bobsburgers.com.au',
            type:         :technical
          }
          registrant         = {
            registrant_name:     "Bob's Burgers Pty Ltd",
            registrant_id:       '12345678912',
            registrant_id_type:  'ABN',
            eligibility_type:    'Company',
            eligibility_name:    "Bob's Burgers Pty Ltd",
            eligibility_id_type: 'ABN',
            eligibility_id:      '12345678912'
          }

          attributes = {
            domain:             domain,
            years:              years,
            name_servers:       Types::DomainList.build(name_servers),
            registrant_contact: Types::AuContact.build(registrant_contact),
            technical_contact:  Types::AuContact.build(technical_contact),
            registrant:         Types::AuRegistrant.build(registrant)
          }

          savon
            .expects(:domain_register_au)
            .with(
              message: message(
                         {
                           domain_name:              'localsearch.com.au',
                           years:                    '2',
                           name_servers:             { item: %w(ns1.myld.com.au ns2.myld.com.au), '@xsi:type' => 'enc:Array' },
                           'registrant_lastname'     => 'Belcher',
                           'registrant_firstname'    => 'Bob',
                           'registrant_organisation' => "Bob's Burgers",
                           'registrant_address'      => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'registrant_suburb'       => "Seymour's Bay",
                           'registrant_state'        => 'QLD',
                           'registrant_country'      => 'AU',
                           'registrant_postcode'     => '4123',
                           'registrant_phone'        => '+61.0751234567',
                           'registrant_fax'          => '',
                           'registrant_email'        => 'bob@bobsburgers.com.au',
                           'technical_lastname'      => 'Belcher',
                           'technical_firstname'     => 'Bob',
                           'technical_organisation'  => "Bob's Burgers",
                           'technical_address'       => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'technical_suburb'        => "Seymour's Bay",
                           'technical_state'         => 'QLD',
                           'technical_country'       => 'AU',
                           'technical_postcode'      => '4123',
                           'technical_phone'         => '+61.0751234567',
                           'technical_fax'           => '',
                           'technical_email'         => 'bob@bobsburgers.com.au',
                           'registrantName'          => "Bob's Burgers Pty Ltd",
                           'registrantID'            => '12345678912',
                           'registrantIDType'        => 'ABN',
                           'eligibilityID'           => '12345678912',
                           'eligibilityIDType'       => 'ABN',
                           'eligibilityName'         => "Bob's Burgers Pty Ltd",
                           'eligibilityType'         => 'Company'
                         }
                       )
            )
            .returns(fixture)

          expect {
            DomainRegisterAu.call(attributes)
          }.to raise_exception(
                 SynergyWholesale::Errors::ResponseError,
                 'Domain Register AU Failed - Domain Not Available To Register'
               )
        end

      end
    end
  end
end
