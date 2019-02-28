class CreateCachedViews < ActiveRecord::Migration[5.2]
  def change
    create_table :cached_views do |t|
      t.text :payload
      t.string :name

      t.timestamps
    end
  end
end
