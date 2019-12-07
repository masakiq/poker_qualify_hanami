class ConvertBord
  attr_reader :bord

  def initialize(bord)
    @bord = bord
  end

  def run
    b = PokerHand.new
    bord.each do |card|
      b << Card.new(Convert.num(card[:num]) + Convert.suit(card[:suit]))
    end
    b
  rescue => e
    puts e.message
  end
end
