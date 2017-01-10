require 'savon'

module SynergyWholesale
  class Adapter

    attr_reader :client

    def initialize
      @client = Savon.client(
        wsdl:       SynergyWholesale.wsdl_path,
        namespaces: { 'xmlns:enc' => 'http://schemas.xmlsoap.org/soap/encoding/' }
      )
    end

    def add_param(key, value)
      params[key] = value
    end

    def add_params(*params)
      return if params.blank?

      if params.size == 1 && params.first.is_a?(Hash)
        params.first.each { |key, value| add_param key, value }
      else
        raise 'params are required to be key/value combinations'
      end
    end

    def params
      @params ||= {
        'resellerID' => SynergyWholesale.reseller_id,
        'apiKey'     => SynergyWholesale.api_key
      }
    end

    def call(action)
      client.call(action, message: { request: params })
    end

  end
end
