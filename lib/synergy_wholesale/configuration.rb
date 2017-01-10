module SynergyWholesale
  module Configuration

    attr_writer :reseller_id,
                :api_key

    def wsdl_path
      'https://api.synergywholesale.com/server.php?wsdl'
    end

    def reseller_id
      raise 'You need to provide a reseller ID to use the Synergy Wholesale API' unless @reseller_id
      @reseller_id
    end

    def api_key
      raise 'You need to provide an API Key to use the Synergy Wholesale API' unless @api_key
      @api_key
    end

  end
end
