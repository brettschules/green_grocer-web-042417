def consolidate_cart(cart)
  hash = {}
  counts_array = []
  counts_hash = Hash.new(0)

  cart.each do |element|
    element.each do |k,v|
      counts_hash[k] += 1
    end
  end

  counts_hash.each { |k,v| counts_array << v }

  cart.each_with_index do |data, index|
    data.each do |food,info|
      hash[food] = info
      hash[food][:count] = counts_array[index-1]
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  return cart if coupons.empty?

  coupon_name = ""
new_coupon_hash = {}
cart.each do |names, values|
  coupons.each do |element|
  if names == element[:item]
    coupon_name = element[:item] = "#{names} W/COUPON"
    new_coupon_hash[coupon_name] = {}
    new_coupon_hash[coupon_name][:price] = element[:cost]
    new_coupon_hash[coupon_name][:clearance] = cart[names][:clearance]
    new_coupon_hash[coupon_name][:count] = cart[names][:count] - element[:num]
    values.each do |k,v|
      cart[names][:count] = (v - element[:num]) if k == :count
    end
  end
end
end

cart.merge(new_coupon_hash)
end

def apply_clearance(cart)
  new_hash = {}

  cart.each do |foods, value|
    value.each do |k,v|
      if k == :clearance && v == true
        prices = ((cart[foods][:price] * 0.20) - (cart[foods][:price])).abs
        new_hash[foods] = value
        new_hash[foods][:price] = prices
      end
    end
  end
  new_hash
end
