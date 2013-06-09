require './kojn.rb'
require 'pp'

Kojn.setup do |config|
  config.api_key = "09367d4b49ae1f1d9ee0a326bd3619f1"
  config.host = "localhost"
  config.port = 3000
  config.ssl = false
end

pp Kojn.invoices.all
pp Kojn.invoices.create(amount_in_euro: 1, currency: 'btc', description: 'Test')
