class Ressource < ApplicationRecord
  has_many :ressource_assignations
  has_many :grids, through: :ressource_assignations
end
