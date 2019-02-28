class CreateRessourceAssignations < ActiveRecord::Migration[5.2]
  def change
    create_table :ressource_assignations do |t|
      t.references :grid, foreign_key: true
      t.references :ressource, foreign_key: true

      t.timestamps
    end
  end
end
