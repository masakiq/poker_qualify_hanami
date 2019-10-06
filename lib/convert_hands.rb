class ConvertHands
  attr_reader :hands

  def initialize(hands)
    @hands = hands
  end

  def run
    hs = []
    hands.each do |hand|
      h = []
      hand.each do |card|
        h << Card.new(Converts.convert_num(card[:num]), Converts.convert_suit(card[:suit]))
      end
      hs << h
    end
    hs
  rescue => e
    puts e.message
  end
end
