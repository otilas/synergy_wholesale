[gem]: https://badge.fury.io/rb/synergy_wholesale
[travis]: https://travis-ci.org/robjacoby/synergy_wholesale
[gemnasium]: https://gemnasium.com/robjacoby/synergy_wholesale

# synergy_wholesale
[![Gem Version](https://badge.fury.io/rb/synergy_wholesale.svg)][gem]
[![Build Status](https://travis-ci.org/robjacoby/synergy_wholesale.svg?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/robjacoby/synergy_wholesale.svg)][gemnasium]

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

# call an operation
response = SynergyWholesale::CheckDomain.call(domain: { name: 'example.com'})

response.body
# => { status: 'UNAVAILABLE', available: '0' }

response.is_available?
# => false

# Or do things manually
# create an instance of the api adapter
api = SynergyWholesale::API.new

# create a command
command = SynergyWholesale::CheckDomain::Command.new(SynergyWholesale::Types::Domain.new(name: 'example.com'))

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
