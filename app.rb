require 'sinatra'
require 'sinatra/activerecord'
require './models/currency'

get '/' do
  @currencies = Currency.all.order("#{params[:sort] || 'rank'} ASC")
  haml :index
end

get '/edit/:id' do
  @currency = Currency.find(params['id'])
  @currency.update_attributes(params['currency'])
  redirect '/'
end
