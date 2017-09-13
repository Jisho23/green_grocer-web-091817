require "pry"

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    if new_cart[item.keys.join("")]
      new_cart[item.keys.join("")][:count] += 1.to_i
    else
      new_cart[item.keys.join("")] = item[item.keys.join("")]
      new_cart[item.keys.join("")][:count] = 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)

  coupons.each do |coupon|

      if cart.include?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
        if cart["#{coupon[:item]} W/COUPON"]
          cart["#{coupon[:item]} W/COUPON"][:count] += 1
          cart[coupon[:item]][:count] -= coupon[:num]
        else
          cart[coupon[:item]][:count] -= coupon[:num]
          cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost], :clearance=>cart[coupon[:item]][:clearance], :count=>1}
        end

    end
  end

  return cart
end

def apply_clearance(cart)
  # code here

  cart.each do |item, values|

    if values[:clearance] == true
      cart[item][:price] = cart[item][:price] * 0.8
      cart[item][:price] = cart[item][:price].round(2)
    end

  end

end

def checkout(cart, coupons)

  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.each do |item, values|

    (values[:count]).times {total += values[:price]}
  end

  if total > 100.00
    total = total * 0.9
    total = total.round(2)
  end
  return total
  # code here
end
