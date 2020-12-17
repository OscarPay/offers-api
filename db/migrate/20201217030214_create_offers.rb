class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.integer :price
      t.string :company

      t.timestamps
    end
  end
end
