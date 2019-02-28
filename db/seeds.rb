BASE_URL =  'https://atlas.gamepedia.com'

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
