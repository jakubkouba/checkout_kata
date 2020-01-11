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
        special_price: {
          count: 3,
          price: 130
        }
      },
      'B' => {
        unit_price: 30,
        special_price: {
          count: 2,
          price: 45
        }
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

  describe 'when items contain AB' do
    let(:items) { 'AB' }
    it { is_expected.to eq 80 }
  end

  describe 'when items contain AAA' do
    let(:items) { 'AAA' }
    it { is_expected.to eq 130 }
  end

  describe 'when items contain AAAA' do
    let(:items) { 'AAAA' }
    it { is_expected.to eq 180 }
  end

  describe 'when items contain DD' do
    let(:items) { 'DD' }
    it { is_expected.to eq 30 }
  end

end