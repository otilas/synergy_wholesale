require 'dry-types'

module SynergyWholesale
  module Types
    include Dry::Types.module
  end
end

require 'synergy_wholesale/types/domain'
require 'synergy_wholesale/types/au_domain'
require 'synergy_wholesale/types/au_id_type'
require 'synergy_wholesale/types/au_organisation_type'
require 'synergy_wholesale/types/au_postcode'
require 'synergy_wholesale/types/au_state'
require 'synergy_wholesale/types/country'
require 'synergy_wholesale/types/domain_list'
require 'synergy_wholesale/types/email'
require 'synergy_wholesale/types/phone'
require 'synergy_wholesale/types/registration_years'
require 'synergy_wholesale/types/contact'
require 'synergy_wholesale/types/au_registrant'
