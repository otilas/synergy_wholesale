module SynergyWholesale
  module Errors
    class ResponseError < Error

      attr_reader :status

      def self.new(command, response)
        @status = response[:status]
        message = response[:error_message] || @status

        super(message, command, response)
      end

    end
  end
end
