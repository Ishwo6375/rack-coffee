  
Coffee.destroy_all

10.times do
  Coffee.create(
    blend: Faker::Coffee.blend_name,
    origin: Faker::Coffee.origin,
    variety: Faker::Coffee.variety,
    price: Faker::Number.number(digits: 2),
    decaf: [true, false].sample
  )
end