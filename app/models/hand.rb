class Hand < ApplicationRecord
  # TODO: Create self.values -> should be sorted, self.suits, and self.values_counted
  has_many :card_hands
  has_many :cards, through: :card_hands

  # validates_uniqueness :true
  # validates_size 5

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

  def is_royal?
    if self.is_flush? && self.values == [10, 11, 12, 13, 14]
      return true
    else
      return false
    end
  end

  def is_flush?
    flush = true
    self.suits.each do |suit|
      flush = false unless suit == self.suits[0]
    end
    return flush
  end

  def is_straight?
    if self.values.uniq.length == 5 && self.values.last - self.values.first == 4
      return true
    else
      return false
    end
  end

  def is_quads?
    if self.values_counted.values.include?(4)
      return true
    else
      return false
    end
  end

  def is_full_house?
    if self.includes_trips? && self.includes_pair?
      return true
    else
      return false
    end
  end

  def includes_trips?
    if self.values_counted.values.include?(3)
      return true
    else
      return false
    end
  end

  def includes_pair?
    if self.values_counted.values.include?(2)
      return true
    else
      return false
    end
  end

  def is_two_pair?
    if self.values_counted.filter{|count| count == 2}.length == 2
      return true
    else
      return false
    end
  end


  def high_card
    high_card = self.values.last
    translated_values = {11 => "J", 12 => "Q", 13 => "K", 14 => "A"}

    return high_card if high_card <= 10
    return translated_values[high_card]
  end

  def analyze_hand
    return "Royal Flush" if self.is_royal?
    return "Straight Flush" if self.is_straight? && self.is_flush?
    return "Four of a Kind" if self.is_quads?
    return "Full House" if self.is_full_house?
    return "Flush" if self.is_flush?
    return "Straight" if self.is_straight?
    return "Three of a Kind" if self.includes_trips?
    return "Two Pair" if self.is_two_pair?
    return "Pair" if self.includes_pair?
    return "#{self.high_card} High"
  end
end
