class CreateCurrency < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string    :uid
      t.string    :name
      t.string    :symbol
      t.integer   :rank
      t.float     :price
      t.string    :price_sym
      t.float     :price_btc
      t.float     :avg_price
      t.float     :market_cap_usd
      t.float     :available_supply
      t.float     :total_supply
      t.float     :change
      t.datetime  :last_updated

      t.timestamps null: false
    end
  end
end
