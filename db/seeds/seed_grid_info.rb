# return false

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "nokogiri"
# require 'pry-byebug'

def trim(object)
  return object.select { |c| c.class == Nokogiri::XML::Element }
end



MAP_URL = 'https://atlas.gamepedia.com/Map'

html_content = open(MAP_URL).read
doc = Nokogiri::HTML(html_content)

rows = doc.search('.wikitable.mw-collapsible tbody tr')

rows.each do |row|
# binding.pry

  row = row.children.select { |c| c.class == Nokogiri::XML::Element }

  next if row[0].text == "Region" # Table Header
  next if row[0].name != "td"     # Each row should start with a td

  # Row has 10 children

  # row[0]  => Region letter#number,
  #         => Thumbnail small url,
  #         => Thumbnail med url,
  cell0 = row[0].children[1].children[0].children[0]
    region = cell0.attributes["alt"].value.upcase
    raise 'Region format error, received : #{region}' if !region.include?('REGION')
    thumbnail_small = cell0.attributes["src"].value
    thumbnail_medium = cell0.attributes["srcset"].value
    source_href = row[0].children[1].children[0].attributes['href'].value
  # row[1] => biome
    biome = row[1].children[0].text.strip
  # row[2] => type
    type = row[2].children[0].text.strip
  # row[7] => animal levels
    animal_levels = row[7].children.select { |c| c.class == Nokogiri::XML::Element }

    if animal_levels.count != 0           #No information available.
      animal_levels = animal_levels[0].text # TODO(SGjunior) : glazed, might not work as intended; review that all data is pulled properly
    else
      animal_levels = 'unknown'
    end

  # row[8] => difficulty
    difficulty = row[8].children.select { |c| c.class == Nokogiri::XML::Element }

    if difficulty.count != 0              #No information available.
      difficulty = difficulty[0].text     # TODO(SGjunior) : glazed, might not work as intended; review that all data is pulled properly
    else
      difficulty = 'unknown'
    end

  # row[9] => notes
  notes = ''
  unless row[9].nil? || row[9].children.nil?
    notes = row[9].children.select { |c| c.class == Nokogiri::XML::Element }
    unless notes.count == 0                   #No information available.
      notes = notes[0].text               # TODO(SGjunior) : glazed, might not work as intended; review that all data is pulled properly
    end
  end

  # Creating the grid.
    grid = Grid.create(
      region: region.gsub(/REGION /, ''),
      biome: biome,
      typeof: type,
      difficulty: difficulty,
      notes: notes,
      source_href: source_href,
      thumbnail_small: thumbnail_small,
      thumbnail_medium: thumbnail_medium,
      row: region.gsub(/REGION /, '').match(/[^.]{1}.+/).to_s,
      index: region.gsub(/REGION /, '').gsub(/^.{1}/, '')
      )

  # row[3] => islands
    islands = row[3].children.select { |c| c.class == Nokogiri::XML::Element }
      islands.each do |island|
        name = island.children[0].text
        source_href = island.attributes['href'] ? island.attributes['href'].value : nil
        # grid =
      end
  # row[4] => ressources

    ressources = row[4].children.select { |c| c.class == Nokogiri::XML::Element }
    unless ressources.count == 0
      ressources = ressources[0].children.select { |c| c.class == Nokogiri::XML::Element }

        ressources.each do |ressource|

          # TODO(SGjunior) : check if the ressource already exists in the DB.
          unless ressource.name == 'br' || ressource.children[0].nil? || ressource.children[0].text == "None discovered" || ressource.children[0].attributes['title'].nil?

            name = ressource.children[0].attributes['title'].value

            ressource_obj = Ressource.find_by(name: name)

            if ressource_obj.nil?
              ressource_obj = Ressource.create(
                name: name,
                source_href: ressource.children[0].attributes['href'].value,
                thumbnail_small: ressource.children[0].children[0].attributes['src'] ? ressource.children[0].children[0].attributes['src'].value : nil,
                thumbnail_medium: ressource.children[0].children[0].attributes['srcset'] ? ressource.children[0].children[0].attributes['srcset'].value : nil,
                # type = # TODO(SGjunior) : not enough information here to determine
              )
            end

            RessourceAssignation.create(
              grid: grid,
              ressource: ressource_obj,
              )
          end
        end
      end

  # row[5] => plants
    plants = row[5].children.select { |c| c.class == Nokogiri::XML::Element }[0]

    unless plants.nil? || plants.text == "None discovered" || plants.text == "None" #No plants discovered for this grid yet.
      plants = plants.children.select { |c| c.class == Nokogiri::XML::Element }

      plants.each do |plant|
        next if plant.children[0].nil? || plant.children[0].attributes['title'].nil?
        name = plant.children[0].attributes['title'].value

        plant_obj = Plant.find_by(name: name)

        if plant_obj.nil?
          # binding.pry
          plant_obj = Plant.create(
            name: name,
            source_href: plant.children[0].attributes['href'].value,
            thumbnail_small: !plant.children[0].children[0].attributes['src'].nil? ? plant.children[0].children[0].attributes['src'].value : nil,
            thumbnail_medium: !plant.children[0].children[0].attributes['src'].nil? ? plant.children[0].children[0].attributes['src'].value : nil,
            # typeof:,
            )
        end

        PlantAssignation.create(
          grid: grid,
          plant: plant_obj
          )

      end
    end

  # row[6] => animals
    animals = row[6].children.select { |c| c.class == Nokogiri::XML::Element }[0]

    unless animals.nil? || animals.text == "None discovered"   #No animals discovered for this grid yet.
      animals = animals.children.select { |c| c.class == Nokogiri::XML::Element }

      animals.each do |animal|

        name = animal.children[0].text

        animal_obj = Animal.find_by(name: name)

        if animal_obj.nil?
          unless animal.children[0].attributes['href'].nil?
            animal_obj = Animal.create(
              name: name,
              source_href: animal.children[0].attributes['href'].value,
              )
          end
        end

        AnimalAssignation.create(
          grid: grid,
          animal: animal_obj
          )
      end
    end




# https://stackoverflow.com/questions/2515931/how-can-i-download-a-file-from-a-url-and-save-it-in-rails

end

