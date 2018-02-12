require 'sinatra/activerecord/rake'
require './lib/fetcher'

namespace :db do
  task :load_config do
    require './app'
  end

  desc 'fetch currencies'
  task fetch: :load_config do
    CurrencyFetcher.fetch
  end
end
