class Card < ApplicationRecord
  attr_accessor :suit, :value, :name

  validates :name, presence: true
  # TODO: fix these validations
  validates :suit, value: ["c", "s", "h", "d"]
  validates :value, value: (2..14)
end
