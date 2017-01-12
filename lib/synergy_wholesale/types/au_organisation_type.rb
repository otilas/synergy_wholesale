module SynergyWholesale
  module Types
    class AuOrganisationType < Dry::Struct

      ORGANISATION_TYPES = [
        'Charity',
        'Citizen/Resident',
        'Club',
        'Commercial Statutory Body',
        'Company',
        'Incorporated Association',
        'Industry Body',
        'Non-profit Organisation',
        'Other',
        'Partnership',
        'Pending TM Owner',
        'Political Party',
        'Registered Business',
        'Religious/Church Group',
        'Sole Trader',
        'Trade Union',
        'Trademark'
      ]

      attribute :organisation_type, Types::Strict::String.constrained(included_in: ORGANISATION_TYPES)

      def to_s
        organisation_type
      end

    end
  end
end
