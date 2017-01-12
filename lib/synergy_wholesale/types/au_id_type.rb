module SynergyWholesale
  module Types
    class AuIDType < Dry::Struct

      ID_TYPES = [
        'ABN',
        'ACN',
        'ACT BN',
        'NSW BN',
        'NT BN',
        'OTHER',
        'QLD BN',
        'SA BN',
        'TAS BN',
        'TM',
        'VIC BN',
        'WA BN'
      ]

      attribute :id_type, Types::Strict::String.constrained(included_in: ID_TYPES)

      def to_s
        id_type
      end

    end
  end
end
