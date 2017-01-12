module SynergyWholesale
  class DisableAutoRenewal < Operation
    class Command < ::Dry::Struct
      attribute :domain, Types::Domain

      def to_param
        domain.to_param
      end

      def operation
        :disable_auto_renewal
      end
    end

    class Response < BaseResponse
      def is_enabled?
        false
      end
    end

    def call(domain)
      command = Command.new(domain)
      api.call(command)
    end

  end
end
