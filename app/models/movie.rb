class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true
  validates :inventory, numericality: { only_integer: true }
  has_many :rentals
end
