class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :tolerance
      t.integer :capacity

      t.timestamps
    end
  end
end
