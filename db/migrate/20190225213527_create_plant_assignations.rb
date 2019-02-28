class CreatePlantAssignations < ActiveRecord::Migration[5.2]
  def change
    create_table :plant_assignations do |t|
      t.references :grid, foreign_key: true
      t.references :plant, foreign_key: true

      t.timestamps
    end
  end
end
