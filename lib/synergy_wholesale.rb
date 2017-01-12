require 'synergy_wholesale/configuration'

module SynergyWholesale
  extend Configuration

  def self.configure
    yield self if block_given?
  end
end

require 'dry-validation'
require 'dry-struct'
require 'synergy_wholesale/api'
require 'synergy_wholesale/errors'
require 'synergy_wholesale/types'
require 'synergy_wholesale/base_response'
require 'synergy_wholesale/operation'
