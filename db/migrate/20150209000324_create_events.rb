class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :blogto_id
      t.string :title
      t.text :body

      t.date :date
      t.time :start_time
      t.time :end_time

      t.string :venue
      t.string :address
      t.string :website
      t.float :latitude
      t.float :longitude
      t.string :image_url

      t.timestamps null: false
    end
  end
end
