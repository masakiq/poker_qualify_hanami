class ConvertBord
  attr_reader :bord

  def initialize(bord)
    @bord = bord
  end

  def run
    b = []
    bord.each do |card|
      b << Card.new(Converts.convert_num(card[:num]), Converts.convert_suit(card[:suit]))
    end
    b
  rescue => e
    puts e.message
  end
end
