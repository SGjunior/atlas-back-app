class AddColumnThumbnailToTableGrids < ActiveRecord::Migration[5.2]
  def change
    add_column :grids, :thumbnail_small, :string
    add_column :grids, :thumbnail_medium, :string

  end

end
