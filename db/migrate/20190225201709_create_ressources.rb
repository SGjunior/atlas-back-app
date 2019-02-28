class CreateRessources < ActiveRecord::Migration[5.2]
  def change
    create_table :ressources do |t|
      t.string :name
      t.string :type
      t.string :source_href
      t.string :thumbnail_small
      t.string :thumbnail_medium

      t.timestamps
    end
  end
end
