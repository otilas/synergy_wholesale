module SynergyWholesale
  module Types
    class Domain < Dry::Struct
      attribute :name, Types::Strict::String

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
