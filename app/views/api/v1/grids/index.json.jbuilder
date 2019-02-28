# binding.pry

json.data @rows.each do |row_id, grids|
   json.grids grids.each do |grid|
      json.extract! grid, :id, :region, :biome, :typeof, :difficulty, :notes, :image, :source_href, :thumbnail_small, :thumbnail_medium, :animals, :plants, :ressources, :islands, :row
    end
end

