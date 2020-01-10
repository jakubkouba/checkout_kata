require_relative '../lib/checkout'
require 'byebug'

RSpec.describe 'Test Price' do

  subject(:price) do
    items.split(//).each { |item| checkout.scan(item) }
    checkout.total
  end

  let(:checkout) { Checkout.new(price_rules) }
  let(:price_rules) do
    {
      'A' => {
        unit_price: 50,
        spectial_price: { 3 => 150 }
      },
      'B' => {
        unit_price: 50,
        spectial_price: { 2 => 45 }
      },
      'C' => {
        unit_price: 20
      },
      'D' => {
        unit_price: 15
      }
    }
  end
  let(:items) {}

  describe 'when items are empty' do
    let(:items) { '' }
    it { is_expected.to eq 0 }
  end

  describe 'when items contain A' do
    let(:items) { 'A' }
    it { is_expected.to eq 50 }
  end

end