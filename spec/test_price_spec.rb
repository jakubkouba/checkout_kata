require_relative '../lib/checkout'

RSpec.describe 'Test Price' do

  subject(:price) do
    items.split(//) { |item| checkout.scan(item) }
    checkout.total
  end

  let(:checkout) { Checkout.new(price_rules) }
  let(:price_rules) {}
  let(:items) {}

  describe 'when items are empty' do
    let(:items) { '' }
    it { is_expected.to eq 0 }
  end

end