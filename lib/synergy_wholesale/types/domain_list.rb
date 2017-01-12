module SynergyWholesale
  module Types
    class DomainList < Dry::Struct

      attribute :domain_list, Types::Strict::Array.member(Types::Domain)

      def self.build(attributes)
        new({ domain_list: attributes[:domain_list].collect { |name| { name: name } } })
      end

      def get_domain_names
        domain_list.collect(&:to_s)
      end

      def to_param
        { name_servers: { item: get_domain_names, '@xsi:type' => 'enc:Array' } }
      end

    end
  end
end
