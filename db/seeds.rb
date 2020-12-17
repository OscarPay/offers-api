require 'csv'

CSV.foreach(Rails.root.join('lib/users.csv')) do |row|
  User.create({
    name: row[1],
    company: row[2]
  })
end

puts 'Users created'

CSV.foreach(Rails.root.join('lib/offers.csv')) do |row|
  Offer.create({
    price: row[2],
    company: row[3]
  })
end

puts 'Offers created'

CSV.foreach(Rails.root.join('lib/departments.csv')) do |row|
  Department.create({
    name: row[1]
  })
end

puts 'Departments created'

CSV.foreach(Rails.root.join('lib/user_departments.csv')) do |row|
  UserDepartment.create({
    user_id: row[1],
    department_id: row[2]
  })
end

puts 'UserDepartments created'

CSV.foreach(Rails.root.join('lib/offer_departments.csv')) do |row|
  OfferDepartment.create({
    offer_id: row[1],
    department_id: row[2]
  })
end

puts 'OfferDepartments created'