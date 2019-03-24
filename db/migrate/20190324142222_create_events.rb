class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.date :starts_at
      t.date :ends_at
      t.integer :tolerance
      t.integer :capacity

      t.timestamps
    end
  end
end
