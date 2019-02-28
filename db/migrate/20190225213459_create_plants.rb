class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :source_href
      t.string :typeof
      t.string :thumbnail_small
      t.string :thumbnail_medium

      t.timestamps
    end
  end
end
