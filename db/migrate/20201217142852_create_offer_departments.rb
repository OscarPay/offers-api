class CreateOfferDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :offer_departments do |t|
      t.references :offer, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
