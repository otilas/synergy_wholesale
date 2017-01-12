module SynergyWholesale
  class BaseResponse

    attr_reader :response, :command

    def initialize(response, command)
      @response = response
      @command  = command

      validate_status
      validate_expected_fields
      validate_data
    end

    def successful?
      [*success_statuses].include?(response[:status])
    end

    def message
      response[:error_message]
    end

    def body
      response
    end

    protected

    def validate_status
      raise Errors::BadDataError.new("No status found in response to Soap command [#{command}]", command, response) unless response[:status]
      raise Errors::ResponseError.new(command, response) unless successful?
    end

    def validate_expected_fields
      return if expected_fields.empty?
      [*expected_fields].each do |expected|
        message = "Expected property [#{expected}] missing from response data"
        raise Errors::BadDataError.new(message, command, response) unless response.has_key?(expected.to_sym)
      end
    end

    def validate_data
      # NO-OP - let subclasses provide their own implementation if they choose
    end

    def success_statuses
      %w(OK ok)
    end

    def expected_fields
      []
    end

  end
end
