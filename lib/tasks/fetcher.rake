desc 'fetch currencies'
task fetch: :environment do
  CurrencyFetcher.fetch
end
