module SynergyWholesale
  module Types
    class AuState < Dry::Struct

      AU_STATES = %w(NSW VIC QLD TAS ACT SA WA NT)

      attribute :state, Types::Strict::String.constrained(included_in: AU_STATES)

      def to_s
        state
      end

    end
  end
end
