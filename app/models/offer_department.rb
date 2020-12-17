class OfferDepartment < ApplicationRecord
  belongs_to :offer
  belongs_to :department
end
