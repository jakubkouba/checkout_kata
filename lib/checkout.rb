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

    items_with_count.reduce(0) do |total, (item, count)|
      item_price_rules = price_rules[item]
      unit_price = UnitPrice.new(item_price_rules[:unit_price], item_price_rules[:special_price])
      total += price_for(count, unit_price)
      total
    end
  end
  
  private

  def price_for(count, unit_price)
    if unit_price.discount?
      apply_discount(count, unit_price)
    else
      count * unit_price.value
    end
  end

  def apply_discount(item_count, unit_price)
    discounted_amount_multiplier = (item_count / unit_price.discounted_amount)
    single_item_count = (item_count % unit_price.discounted_amount)
    
    discounted_price = discounted_amount_multiplier * unit_price.discounted_price
    price_for_single_units = single_item_count * unit_price.value

    discounted_price + price_for_single_units
  end

  def items_with_count
    @items_count = items.inject(Hash.new(0)) do |items_count, item|
      items_count[item] += 1
      items_count
    end
  end

end

class UnitPrice

  attr_reader :value

  def initialize(price, discount)
    @value = price
    @discount = discount
  end

  def discount?
    !@discount.nil?
  end

  def discounted_amount
    @discount[:count]
  end

  def discounted_price
    @discount[:price]
  end

end