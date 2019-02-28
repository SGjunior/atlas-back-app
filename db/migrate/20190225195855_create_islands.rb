class CreateIslands < ActiveRecord::Migration[5.2]
  def change
    create_table :islands do |t|
      t.string :name
      t.string :source_href
      t.references :grid, foreign_key: true

      t.timestamps
    end
  end
end
