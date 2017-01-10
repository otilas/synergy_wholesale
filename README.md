# synergy_wholesale

## Installation

Synergy Wholesale is available through [Rubygems](http://rubygems.org/gems/synergy_wholesale) and can be installed via:

```
$ gem install synergy_wholesale
```

or add it to your Gemfile like this:

```
gem 'synergy_wholesale'
```

## Usage example

``` ruby
require 'synergy_wholesale'

# configure Synergy Wholesale
SynergyWholesale.setup do |config|
  config.reseller_id = '12345'
  config.api_key = 'abc123'
end

# create an instance of the api adapter
api = SynergyWholesale::API.new

# create a command
command = Commands::CheckDomain.new(Entities::Domain.new('example.com'))

command.to_param
# => { domain_name: 'example.com' }

# call the 'checkDomain' command
response = api.call(command)

response.body
# => { status: 'UNAVAILABLE', available: '0' }

response.is_available?
# => false
```

## License

See `LICENSE` file.
