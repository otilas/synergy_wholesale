require 'synergy_wholesale/configuration'

module SynergyWholesale
  extend Configuration

  def self.configure
    yield self if block_given?
  end
end
