module SynergyWholesale
  module Types
    class AuPostcode < Dry::Struct

      attribute :postcode, Types::Strict::String.constrained(format: /\d{4}/)

      def to_s
        postcode
      end

    end
  end
end
