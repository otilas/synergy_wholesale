module SynergyWholesale
  module Types
    class Contact < Dry::Struct
      attribute :organisation, Types::Strict::String.optional
      attribute :firstname, Types::Strict::String
      attribute :lastname, Types::Strict::String
      attribute :address, Types::Strict::Array.constrained(filled: true)
      attribute :suburb, Types::Strict::String
      attribute :state, Types::Strict::String
      attribute :postcode, Types::Strict::String

      attribute :country, Types::Country
      attribute :phone, Types::Phone
      attribute :fax, Types::Phone
      attribute :email, Types::Email
      attribute :type, Types::Strict::Symbol.constrained(included_in: %i(billing admin technical registrant))

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
