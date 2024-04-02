class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :category
      t.time :pick_up_from
      t.time :pick_up_till
      t.time :return_from
      t.time :return_till
      t.string :country
      t.string :state
      t.string :city
      t.string :postcode
      t.string :address_1
      t.string :address_2
      t.text :description
      t.boolean :available
      t.float :price_per_day

      t.timestamps
    end
  end
end
