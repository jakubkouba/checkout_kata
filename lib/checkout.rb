require 'byebug'

class Checkout

  attr_reader :items, :price_rules

  def initialize(price_rules)
    @price_rules = price_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    return 0 if items.empty?

    total = 0
    items.each do |item|
      item_price_rules = price_rules[item]
      total += item_price_rules[:unit_price]
    end
    total
  end

end