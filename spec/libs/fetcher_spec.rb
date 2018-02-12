require 'spec_helper'

RSpec.describe CurrencyFetcher do
  
  let(:response) do
    {
      'id' => 'singularitynet',
      'name' => 'SingularityNET',
      'symbol' => 'AGI',
      'rank' => '99',
      'price_usd' => '0.398751',
      'price_btc' => '0.00004541',
      '24h_volume_usd' => '1106170.0',
      'market_cap_usd' => '181652127.0',
      'available_supply' => '455552782.0',
      'total_supply' => '1000000000.0',
      'max_supply' => nil,
      'percent_change_1h' => '4.42',
      'percent_change_24h' => '4.54',
      'percent_change_7d' => '0.62',
      'last_updated' => '1518440659'
    }
  end

  before do
    Currency.connection
  end

  describe '#fetch' do
    subject { CurrencyFetcher.fetch }

    it 'expected to fetch and save data' do
      allow(JSON).to receive(:parse).and_return([response])
      expect_any_instance_of(Currency).to receive(:update_attributes)
      subject
    end
  end

  describe '#currency_params' do
    subject { CurrencyFetcher.send(:currency_params, response) }

    it 'should transform params' do
      expect(subject).to be_an_instance_of(Hash)
      expect(subject).to have_key('price')
      expect(subject).to have_key('avg_price')
      expect(subject).to have_key('change')
      expect(subject).to have_key('last_updated')
    end

    it 'should has correct params' do
      expect(subject['change']).to eq '4.54'
      expect(subject['price']).to eq '0.398751'
      expect(subject['avg_price']).to eq '1106170.0'
      expect(subject['last_updated'].to_i).to eq DateTime.now.to_i
    end
  end
end
