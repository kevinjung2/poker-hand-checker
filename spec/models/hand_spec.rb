describe Hand do
  context "when it analyzes a hand" do
    it 'recognizes a royal flush' do
      royal_flush = Hand.create(cards: ["AH", "KH", "QH", "JH", "10H"].map {|card| Card.find_by(name: card)})

      expect(royal_flush.analyze_hand).to eq("Royal Flush")
    end

    it 'recognizes a straight flush' do
      straight_flush = Hand.create(cards: ["9H", "KH", "QH", "JH", "10H"].map {|card| Card.find_by(name: card)})

      expect(straight_flush.analyze_hand).to eq("Straight Flush")
    end

    it 'recognizes a four of a kind' do
      quads = Hand.create(cards: ["AH", "AC", "AS", "AD", "10H"].map {|card| Card.find_by(name: card)})

      expect(quads.analyze_hand).to eq("Four of a Kind")
    end

    it 'recognizes a full house' do
      full_house = Hand.create(cards: ["AH", "AC", "AS", "JH", "JS"].map {|card| Card.find_by(name: card)})

      expect(full_house.analyze_hand).to eq("Full House")
    end

    it 'recognizes a flush' do
      flush = Hand.create(cards: ["6H", "4H", "QH", "JH", "10H"].map {|card| Card.find_by(name: card)})

      expect(flush.analyze_hand).to eq("Flush")
    end

    it 'recognizes a straight' do
      straight = Hand.create(cards: ["9H", "KD", "QS", "JH", "10H"].map {|card| Card.find_by(name: card)})

      expect(straight.analyze_hand).to eq("Straight")
    end

    it 'recognizes a straight with a low ace' do
      straight = Hand.create(cards: ["AH", "2D", "3S", "4H", "5H"].map {|card| Card.find_by(name: card)})

      expect(straight.analyze_hand).to eq("Straight")
    end

    it 'recognizes trips' do
      trips = Hand.create(cards: ["AH", "AC", "AS", "JH", "10H"].map {|card| Card.find_by(name: card)})

      expect(trips.analyze_hand).to eq("Three of a Kind")
    end

    it 'recognizes two pair' do
      two_pair = Hand.create(cards: ["AH", "AC", "QH", "QS", "10H"].map {|card| Card.find_by(name: card)})

      expect(two_pair.analyze_hand).to eq("Two Pair")
    end

    it 'recognizes a pair' do
      pair = Hand.create(cards: ["AH", "AS", "QH", "JH", "10H"].map {|card| Card.find_by(name: card)})

      expect(pair.analyze_hand).to eq("One Pair")
    end

    it 'recognizes high card' do
      high_card = Hand.create(cards: ["AH", "6H", "3S", "2D", "10H"].map {|card| Card.find_by(name: card)})

      expect(high_card.analyze_hand).to eq("A High")
    end

    it 'returns invalid hand for hands with more than 5 cards' do
      six_card_hand = Hand.create(cards: ["AH", "KH", "QH", "JH", "10H", "9H"].map {|card| Card.find_by(name: card)})

      expect(six_card_hand.analyze_hand).to eq("Invalid Hand")
    end

    it 'returns invalid hand for hands with less than 5 cards' do
      four_card_hand = Hand.create(cards: ["AH", "KH", "QH", "JH"].map {|card| Card.find_by(name: card)})

      expect(four_card_hand.analyze_hand).to eq("Invalid Hand")
    end

    it 'returns invalid hand for hands with duplicate cards' do
      duplicate_card_hand = Hand.create(cards: ["AH", "KH", "QH", "JH", "JH"].map {|card| Card.find_by(name: card)})

      expect(duplicate_card_hand.analyze_hand).to eq("Invalid Hand")
    end
  end
end
