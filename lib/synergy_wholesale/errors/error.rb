module SynergyWholesale
  module Errors
    class Error < StandardError

      attr_reader :command, :response

      def self.new(message, command, response)
        @command  = command
        @response = response
        super(message)
      end

    end
  end
end
