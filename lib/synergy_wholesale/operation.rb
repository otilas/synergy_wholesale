module SynergyWholesale
  class Operation

    def self.call(attrs)
      new.call(attrs)
    end

    protected

    def api
      @api ||= API.new
    end

  end
end

require_relative 'operations/check_domain'
