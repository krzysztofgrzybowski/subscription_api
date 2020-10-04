plans = {
  'Bronze Box': 19.99,
  'Silver Box': 49.00,
  'Gold Box': 99.00
}

plans.each do |name, price|
  SubscriptionPlan.create(name: name, price: price)
end
