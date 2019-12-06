class ConvertHands
  attr_reader :hands

  def initialize(hands)
    @hands = hands
  end

  def run
    hs = []
    hands.each do |hand|
      h = PokerHand.new
      hand.each do |card|
        h << Card.new(Convert.num(card[:num]) + Convert.suit(card[:suit]))
      end
      hs << h
    end
    hs
  rescue => e
    puts e.message
  end
end
