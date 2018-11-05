class Rental < ApplicationRecord
  validates :checkout, presence: true
  belongs_to :movie
  belongs_to :customer
end
