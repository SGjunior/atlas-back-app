class CreateAnimalAssignations < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_assignations do |t|
      t.references :grid, foreign_key: true
      t.references :animal, foreign_key: true

      t.timestamps
    end
  end
end
