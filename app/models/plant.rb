class Plant < ApplicationRecord
  has_many :plant_assignations
  has_many :grid, through: :plant_assignations
end
