module SynergyWholesale
  class CheckDomain < Operation
    class Command < ::Dry::Struct
      attribute :domain, Types::Domain

      def to_param
        domain.to_param
      end

      def operation
        :check_domain
      end
    end

    class Response < BaseResponse
      def is_available?
        response[:status] == 'AVAILABLE'
      end

      protected

      def success_statuses
        %w(AVAILABLE UNAVAILABLE)
      end

    end

    def call(domain)
      command = Command.new(domain)
      api.call(command)
    end

  end
end
