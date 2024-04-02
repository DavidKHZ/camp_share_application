class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.date :from
      t.date :to
      t.string :status

      t.timestamps
    end
  end
end
