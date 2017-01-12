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
