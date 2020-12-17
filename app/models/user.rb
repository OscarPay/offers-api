class User < ApplicationRecord
  has_many :user_departments
  has_many :departments, :through => :user_departments
end
