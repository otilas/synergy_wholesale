module SynergyWholesale
  module Types
    class AuContact < Dry::Struct
      attribute :organisation, Types::Strict::String.optional
      attribute :firstname, Types::Strict::String
      attribute :lastname, Types::Strict::String
      attribute :address, Types::Strict::Array.constrained(filled: true)
      attribute :suburb, Types::Strict::String

      attribute :state, Types::AuState
      attribute :postcode, Types::AuPostcode
      attribute :country, Types::Country
      attribute :phone, Types::Phone
      attribute :fax, Types::Phone.optional
      attribute :email, Types::Email
      attribute :type, Types::Strict::Symbol.constrained(included_in: %i(billing admin technical registrant))

      def self.build(attributes)
        new(
          {
            firstname:    attributes[:firstname],
            lastname:     attributes[:lastname],
            organisation: attributes[:organisation],
            address:      attributes[:address],
            suburb:       attributes[:suburb],
            state:        { state: attributes[:state] },
            country:      { country_code: attributes[:country] },
            postcode:     { postcode: attributes[:postcode] },
            phone:        { phone: attributes[:phone] },
            fax:          attributes[:fax] ? { phone: attributes[:fax] } : nil,
            email:        { email: attributes[:email] },
            type:         attributes[:type]
          }
        )
      end

      def to_param
        {
          prefixed(:lastname)     => lastname,
          prefixed(:firstname)    => firstname,
          prefixed(:organisation) => organisation,
          prefixed(:address)      => { item: address, '@xsi:type' => 'enc:Array' },
          prefixed(:suburb)       => suburb,
          prefixed(:state)        => state.to_s,
          prefixed(:country)      => country.to_s,
          prefixed(:postcode)     => postcode.to_s,
          prefixed(:phone)        => phone.to_s,
          prefixed(:fax)          => fax.to_s,
          prefixed(:email)        => email.to_s
        }
      end

      protected

      def prefixed(attr)
        "#{type}_#{attr}"
      end

    end
  end
end
