class CreateGrids < ActiveRecord::Migration[5.2]
  def change
    create_table :grids do |t|
      t.string :region, index: true
      t.string :biome
      t.string :typeof
      t.string :difficulty
      t.string :notes
      t.string :image
      t.string :source_href
    end
  end
end
