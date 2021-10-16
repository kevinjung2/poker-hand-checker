class Hand < ApplicationRecord
  # TODO: Create self.values -> should be sorted, self.suits, and self.values_counted
  validates_uniqueness :true
  validates_size 5

  def is_royal?
    if self.isFLush? && self.values == [10, 11, 12, 13, 14]
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
    if self.values_counted.values.includes?(4)
      return true
    else
      return false
    end
  end

  def is_full_house?
    if self.includes_trips && self.includes_pair
      return true
    else
      return false
    end
  end

  def includes_trips?
    if self.values_counted.values.inludes?(3)
      return true
    else
      return false
    end
  end

  def includes_pair?
    if self.values_counted.values.includes?(2)
      return true
    else
      return false
    end
  end

  def high_card
    high_card = self.values.last
    translated_values = {11: "J", 12: "Q", 13: "K", 14: "A"}

    return high_card if high_card <= 10
    return translated_values[high_card]
  end

  def analyze_hand
    case self
    when self.is_royal?
      return "Royal Flush"
    when self.is_straight? && self.is_flush?
      return "Straight Flush"
    when self.is_quads?
      return "Four of a Kind"
    when self.is_full_house?
      return "Full House"
    when self.is_flush?
      return "Flush"
    when self.is_straight?
      return "Straight"
    when self.includes_trips?
      return "Trips"
    when self.includes_pair?
      return "Pair"
    else
      return '${self.high_card} High'
    end

  end
end
