class CreateFlats < ActiveRecord::Migration[7.1]
  def change
    create_table :flats do |t|
      t.string :title
      t.text :description
      t.string :location
      t.integer :price
      t.date :availability_start
      t.date :availibility_end
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
