module SynergyWholesale
  class EnableAutoRenewal < Operation
    class Command < ::Dry::Struct
      attribute :domain, Types::Domain

      def to_param
        domain.to_param
      end

      def operation
        :enable_auto_renewal
      end
    end

    class Response < BaseResponse
      def is_enabled?
        true
      end
    end

    def call(domain)
      command = Command.new(domain)
      api.call(command)
    end

  end
end
