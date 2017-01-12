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
require_relative 'operations/enable_auto_renewal'
require_relative 'operations/disable_auto_renewal'
