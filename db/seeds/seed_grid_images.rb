return false
# https://atlas.gamepedia.com/
require "open-uri"
require "nokogiri"
require 'pry-byebug'

Grid.all.each do |grid|

  # binding.pry
  puts "Fetching image url for #{grid.region}"
  html_content = open(BASE_URL+grid.source_href).read
  doc = Nokogiri::HTML(html_content)

  img = doc.search("[alt='Region #{grid.region}.jpg']")[0]
  img_url = img.attributes['srcset'].value
  img_url = img_url.gsub(img_url[/[^,]+/], '').gsub(', ', '')

  grid.update(image: img_url)

  # open("../public/grids/#{grid.region}_lg.jpg", 'wb') do |file|
  #   file << open(img_url).read
  # end
  # download = open(img_url)
  # IO.copy_stream(open(img_url), "../public/grids/#{grid.region}_lg.jpg")
  # File.join(_DIR__)
  # IO.copy_stream(download, "~/../public/grids/#{grid.region}_lg.jpg")
  # File.write "#{grid.region}_lg.jpg", open(img_url, 'wb').read


  # open(img_url) {|f|
  #    File.open("whatever_file.jpg","wb") do |file|
  #      file.puts f.read
  #    end
  # }

  # File.open(Rails.root.join("public/")+"#{grid.region}_lg.jpg", 'upload', uploaded_io.original_filename), 'wb') do |file|
  #   file.write(uploaded_io.read)
  # end

end
