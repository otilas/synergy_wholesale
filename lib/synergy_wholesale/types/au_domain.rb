module SynergyWholesale
  module Types
    class AuDomain < ::Dry::Struct
      attribute :name, Types::Strict::String.constrained(format: /\.au\z/)

      def to_param
        {
          domain_name: name
        }
      end

      def to_s
        name
      end
    end
  end
end
