class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :body
      t.date :date
      t.time :time
      t.string :venue
      t.string :address
      t.string :website

      t.timestamps null: false
    end
  end
end
