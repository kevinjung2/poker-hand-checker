class Hand < ApplicationRecord
  has_many :card_hands
  has_many :cards, through: :card_hands


  def values
    self.cards.map{|card| card.value}.sort
  end

  def suits
    self.cards.map{|card| card.suit}
  end

  def values_counted
    values = {}
    self.values.each do |value|
      values[value] ? values[value] += 1 : values[value] = 1
    end
    values
  end

  def card_names
    self.cards.map{|card| card.name}
  end

  def is_royal?
    self.is_flush? && self.values == [10, 11, 12, 13, 14]
  end

  def is_flush?
    flush = true
    self.suits.each do |suit|
      flush = false unless suit == self.suits[0]
    end
    return flush
  end

  def is_straight?
    (self.values.uniq.length == 5 && self.values.last - self.values.first == 4) || self.values == [2, 3, 4, 5, 14]
  end

  def is_quads?
    self.values_counted.values.include?(4)
  end

  def is_full_house?
    self.includes_trips? && self.includes_pair?
  end

  def includes_trips?
    self.values_counted.values.include?(3)
  end

  def includes_pair?
    self.values_counted.values.include?(2)
  end

  def is_two_pair?
    self.values_counted.values.filter{|count| count == 2}.length == 2
  end


  def high_card
    high_card = self.values.last
    translated_values = {11 => "J", 12 => "Q", 13 => "K", 14 => "A"}

    return high_card if high_card <= 10
    return translated_values[high_card]
  end

  def analyze_hand
    return "Invalid Hand" if self.cards.length != 5 || self.card_names.uniq.length != self.card_names.length
    return "Royal Flush" if self.is_royal?
    return "Straight Flush" if self.is_straight? && self.is_flush?
    return "Four of a Kind" if self.is_quads?
    return "Full House" if self.is_full_house?
    return "Flush" if self.is_flush?
    return "Straight" if self.is_straight?
    return "Three of a Kind" if self.includes_trips?
    return "Two Pair" if self.is_two_pair?
    return "One Pair" if self.includes_pair?
    return "#{self.high_card} High"
  end
end
