require_relative 'inflector'

module SynergyWholesale
  class ResponseGenerator

    def build_response(command_name, response, soap_command)
      get_response_class(command_name).new(response, soap_command)
    end

    protected

    def get_response_class(command_name)
      response_class = command_name.gsub('Command', 'Response')
      Inflector.constantize(response_class)
    end

  end
end
