class Department < ApplicationRecord
  has_many :user_departments
  has_many :users, :through => :user_departments

  has_many :offer_departments
  has_many :offers, :through => :offer_departments
end
