module SynergyWholesale
  class DomainRegister < Operation
    class Command < Dry::Struct
      attribute :domain, Types::Domain
      attribute :years, Types::RegistrationYears
      attribute :name_servers, Types::DomainList
      attribute :registrant_contact, Types::Contact
      attribute :technical_contact, Types::Contact
      attribute :billing_contact, Types::Contact
      attribute :admin_contact, Types::Contact
      attribute :id_protect, Types::Bool.optional

      def to_param
        params = {
          id_protect: id_protect ? 'Y' : ''
        }
        params.merge!(domain.to_param)
        params.merge!(years.to_param)
        params.merge!(name_servers.to_param)
        params.merge!(registrant_contact.to_param)
        params.merge!(technical_contact.to_param)
        params.merge!(billing_contact.to_param)
        params.merge!(admin_contact.to_param)

        params
      end

      def operation
        :domain_register
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
