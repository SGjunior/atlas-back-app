return false

require "open-uri"
require "nokogiri"
require 'pry-byebug'


Grid.all.each do |grid|

  puts "Fetching LG image for grid #{grid.region}"

  open(grid.image) {|f|
     File.open(Rails.root.join('public/grids/') + "#{grid.region}_lg.jpg","wb") do |file|
     file.puts f.read
   end

  sleep 2
}

end
