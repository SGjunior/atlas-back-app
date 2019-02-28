class Animal < ApplicationRecord
  has_many :animal_assignations
  has_many :grids, through: :animal_assignations

  # validates :source_href, presence: true
end
