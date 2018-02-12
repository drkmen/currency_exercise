require 'net/http'
require 'json'
require './models/currency'

class CurrencyFetcher

  CURRENCIES = %w(AUD BRL CAD CHF CLP CNY CZK DKK EUR GBP HKD HUF IDR ILS INR
                  JPY KRW MXN MYR NOK NZD PHP PKR PLN RUB SEK SGD THB TRY TWD ZAR)

  def self.fetch(url = nil)
    url ||= 'https://api.coinmarketcap.com/v1/ticker/'
    response = JSON.parse(Net::HTTP.get(URI(url)))
    response.each do |currency|
      curr = Currency.find_or_create_by(uid: currency['id'])
      curr.update_attributes(currency_params(currency))
    end
  end

  private

  def self.currency_params(params)
    attrs = params
    attrs.delete('max_supply')
    attrs.delete('percent_change_1h')
    attrs.delete('percent_change_7d')
    attrs.delete('id')
    attrs.tap do |param|
      param['price'] = attrs.delete('price_usd')
      param['avg_price'] = attrs.delete('24h_volume_usd')
      param['change'] = attrs.delete('percent_change_24h')
      param['last_updated'] = DateTime.now
    end
    attrs
  end
end
