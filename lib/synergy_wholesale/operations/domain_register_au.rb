module SynergyWholesale
  class DomainRegisterAu < Operation
    class Command < Dry::Struct
      attribute :domain, Types::Domain
      attribute :years, Types::RegistrationYears
      attribute :name_servers, Types::DomainList
      attribute :registrant_contact, Types::AuContact
      attribute :technical_contact, Types::AuContact
      attribute :registrant, Types::AuRegistrant

      def to_param
        params = {}
        params.merge!(domain.to_param)
        params.merge!(years.to_param)
        params.merge!(name_servers.to_param)
        params.merge!(registrant_contact.to_param)
        params.merge!(technical_contact.to_param)
        params.merge!(registrant.to_param)

        params
      end

      def operation
        :domain_register_au
      end
    end

    class Response < BaseResponse
      def validate_data
        raise Errors::BadDataError.new('Expected a numeric cost price', command, response) unless Inflector.is_numeric?(response[:cost_price])
      end

      protected

      def expected_fields
        %w(cost_price)
      end
    end

    def call(attributes)
      command = Command.new(attributes)
      api.call(command)
    end

  end
end
