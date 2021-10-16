class Card < ApplicationRecord
  attr_accessor :suit, :value, :name

  has_many :card_hands
  has_many :hands, through: card_hands

  validates :name, presence: true
  # TODO: fix these validations
  validates :suit, value: ["c", "s", "h", "d"]
  validates :value, value: (2..14)
end
