module SynergyWholesale
  module Types
    class RegistrationYears < Dry::Struct
      attribute :years, Types::Coercible::Int.constrained(gteq: 1, lteq: 10)

      def to_param
        { years: years.to_s }
      end

    end
  end
end
