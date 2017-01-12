require 'savon/mock/spec_helper'

module SynergyWholesale

  RSpec.describe DomainRegister do
    include Savon::SpecHelper

    # set Savon in and out of mock mode
    before(:all) { savon.mock! }
    after(:all) { savon.unmock! }

    def message(params)
      core_params = API.new.adapter.params
      { request: core_params.merge(params) }
    end

    describe 'DomainRegister' do
      context 'with valid parameters' do

        it 'registers the domain' do
          fixture = File.read('spec/fixtures/synergy/domain/register/success.xml')

          domain       = { name: 'bobsburgers.com' }
          years        = { years: 2 }
          name_servers = { domain_list: %w(ns1.example.com ns2.example.com) }
          contact      = {
            firstname:    'Bob',
            lastname:     'Belcher',
            organisation: "Bob's Burgers",
            address:      ['123 Ocean Avenue'],
            suburb:       "Seymour's Bay",
            state:        'QLD',
            country:      'AU',
            postcode:     '4123',
            phone:        '+61.0751234567',
            email:        'bob@bobsburgers.com.au'
          }

          attributes = {
            domain:             domain,
            years:              years,
            name_servers:       Types::DomainList.build(name_servers),
            registrant_contact: Types::Contact.build(contact.merge(type: :registrant)),
            technical_contact:  Types::Contact.build(contact.merge(type: :technical)),
            billing_contact:    Types::Contact.build(contact.merge(type: :billing)),
            admin_contact:      Types::Contact.build(contact.merge(type: :admin)),
            id_protect:         false
          }

          savon
            .expects(:domain_register)
            .with(
              message: message(
                         {
                           id_protect:               '',
                           domain_name:              'bobsburgers.com',
                           years:                    '2',
                           name_servers:             { item: %w(ns1.example.com ns2.example.com), '@xsi:type' => 'enc:Array' },
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
                           'billing_lastname'        => 'Belcher',
                           'billing_firstname'       => 'Bob',
                           'billing_organisation'    => "Bob's Burgers",
                           'billing_address'         => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'billing_suburb'          => "Seymour's Bay",
                           'billing_state'           => 'QLD',
                           'billing_country'         => 'AU',
                           'billing_postcode'        => '4123',
                           'billing_phone'           => '+61.0751234567',
                           'billing_fax'             => '',
                           'billing_email'           => 'bob@bobsburgers.com.au',
                           'admin_lastname'          => 'Belcher',
                           'admin_firstname'         => 'Bob',
                           'admin_organisation'      => "Bob's Burgers",
                           'admin_address'           => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'admin_suburb'            => "Seymour's Bay",
                           'admin_state'             => 'QLD',
                           'admin_country'           => 'AU',
                           'admin_postcode'          => '4123',
                           'admin_phone'             => '+61.0751234567',
                           'admin_fax'               => '',
                           'admin_email'             => 'bob@bobsburgers.com.au'
                         }
                       )
            )
            .returns(fixture)


          expect(DomainRegister.call(attributes)).to be_successful
        end

      end

      context 'with invalid parameters' do

        it 'returns an error' do
          fixture = File.read('spec/fixtures/synergy/domain/register/failure.xml')

          domain       = { name: 'google.com' }
          years        = { years: 2 }
          name_servers = { domain_list: %w(ns1.example.com ns2.example.com) }
          contact      = {
            firstname:    'Bob',
            lastname:     'Belcher',
            organisation: "Bob's Burgers",
            address:      ['123 Ocean Avenue'],
            suburb:       "Seymour's Bay",
            state:        'QLD',
            country:      'AU',
            postcode:     '4123',
            phone:        '+61.0751234567',
            email:        'bob@bobsburgers.com.au'
          }

          attributes = {
            domain:             domain,
            years:              years,
            name_servers:       Types::DomainList.build(name_servers),
            registrant_contact: Types::Contact.build(contact.merge(type: :registrant)),
            technical_contact:  Types::Contact.build(contact.merge(type: :technical)),
            billing_contact:    Types::Contact.build(contact.merge(type: :billing)),
            admin_contact:      Types::Contact.build(contact.merge(type: :admin)),
            id_protect:         false
          }

          savon
            .expects(:domain_register)
            .with(
              message: message(
                         {
                           id_protect:               '',
                           domain_name:              'google.com',
                           years:                    '2',
                           name_servers:             { item: %w(ns1.example.com ns2.example.com), '@xsi:type' => 'enc:Array' },
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
                           'billing_lastname'        => 'Belcher',
                           'billing_firstname'       => 'Bob',
                           'billing_organisation'    => "Bob's Burgers",
                           'billing_address'         => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'billing_suburb'          => "Seymour's Bay",
                           'billing_state'           => 'QLD',
                           'billing_country'         => 'AU',
                           'billing_postcode'        => '4123',
                           'billing_phone'           => '+61.0751234567',
                           'billing_fax'             => '',
                           'billing_email'           => 'bob@bobsburgers.com.au',
                           'admin_lastname'          => 'Belcher',
                           'admin_firstname'         => 'Bob',
                           'admin_organisation'      => "Bob's Burgers",
                           'admin_address'           => { item: ['123 Ocean Avenue'], '@xsi:type' => 'enc:Array' },
                           'admin_suburb'            => "Seymour's Bay",
                           'admin_state'             => 'QLD',
                           'admin_country'           => 'AU',
                           'admin_postcode'          => '4123',
                           'admin_phone'             => '+61.0751234567',
                           'admin_fax'               => '',
                           'admin_email'             => 'bob@bobsburgers.com.au'
                         }
                       )
            )
            .returns(fixture)

          expect {
            DomainRegister.call(attributes)
          }.to raise_exception(
                 SynergyWholesale::Errors::ResponseError,
                 'Domain Register Failed - Domain Not Available To Register'
               )
        end

      end
    end
  end
end
