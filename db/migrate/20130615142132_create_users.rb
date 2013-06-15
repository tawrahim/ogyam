class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :location
      t.string :image_url
      t.string :bio
      t.date   :time_zone

      t.timestamps
    end
  end
end
