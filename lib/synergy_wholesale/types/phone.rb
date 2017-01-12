module SynergyWholesale
  module Types
    class Phone < Dry::Struct

      attribute :phone, Types::Strict::String.constrained(format: /^\+[0-9]{1,2}\.[0-9]{6,10}$/)

      def to_s
        phone
      end

    end
  end
end
