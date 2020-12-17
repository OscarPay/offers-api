class Offer < ApplicationRecord
  has_many :offer_departments
  has_many :departments, :through => :offer_departments
end
