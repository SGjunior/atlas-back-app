class AddColumnRowAndIndexToGrid < ActiveRecord::Migration[5.2]
  def change
    add_column :grids, :row, :string
    add_column :grids, :index, :integer
  end
end
