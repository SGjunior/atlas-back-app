class Grid < ApplicationRecord
  has_many :ressource_assignations
  has_many :ressources, through: :ressource_assignations
  has_many :animal_assignations
  has_many :animals, through: :animal_assignations
  has_many :plant_assignations
  has_many :plants, through: :plant_assignations
  has_many :islands
end
