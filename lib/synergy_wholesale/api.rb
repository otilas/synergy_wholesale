require_relative 'adapter'
require_relative 'response_generator'
require_relative 'inflector'

module SynergyWholesale
  class API

    attr_writer :adapter, :response_generator

    def adapter
      @adapter ||= Adapter.new
    end

    def response_generator
      @response_generator ||= ResponseGenerator.new
    end

    def call(command)
      adapter.add_params(command.to_param)
      command_name = command.class.name
      soap_command = Inflector.underscore(Inflector.demodulize(command_name)).to_sym

      savon_response = adapter.call(soap_command)
      response       = savon_response.body["#{soap_command}_response".to_sym][:return]
      response_generator.build_response(command_name, response, soap_command)
    end

  end
end
