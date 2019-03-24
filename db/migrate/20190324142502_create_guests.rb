class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.string :name
      t.references :event, foreign_key: true
      t.datetime :time_of_arrival
      t.string :document
      t.string :status

      t.timestamps
    end
  end
end
