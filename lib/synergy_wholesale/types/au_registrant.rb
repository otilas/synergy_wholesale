module SynergyWholesale
  module Types
    class AuRegistrant < Dry::Struct

      attribute :registrant_name, Types::Strict::String
      attribute :registrant_id, Types::Strict::String.constrained(size: 9) | Types::Strict::String.constrained(size: 11)
      attribute :registrant_id_type, Types::AuIDType.optional
      attribute :eligibility_name, Types::Strict::String.optional
      attribute :eligibility_id, Types::Strict::String.constrained(size: 9) | Types::Strict::String.constrained(size: 11)
      attribute :eligibility_type, Types::AuOrganisationType
      attribute :eligibility_id_type, Types::AuIDType.optional

      def self.build(attributes)
        new(
          {
            registrant_name:     attributes[:registrant_name],
            registrant_id:       attributes[:registrant_id],
            registrant_id_type:  { id_type: attributes[:registrant_id_type] },
            eligibility_type:    { organisation_type: attributes[:eligibility_type] },
            eligibility_name:    attributes[:eligibility_name],
            eligibility_id_type: { id_type: attributes[:eligibility_id_type] },
            eligibility_id:      attributes[:eligibility_id]
          }
        )
      end

      def to_param
        {
          'registrantName'    => registrant_name,
          'registrantID'      => registrant_id,
          'registrantIDType'  => registrant_id_type.to_s,
          'eligibilityID'     => eligibility_id,
          'eligibilityIDType' => eligibility_id_type.to_s,
          'eligibilityName'   => eligibility_name,
          'eligibilityType'   => eligibility_type.to_s
        }
      end

    end
  end
end
