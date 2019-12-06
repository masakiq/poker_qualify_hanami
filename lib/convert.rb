class Convert
  def self.num(num)
    ten = { '10' => 't' }
    n = ten[num]
    n ? n : num
  end

  def self.suit(suit)
    suits = { 'hearts' => 'h', 'spades' => 's', 'diams' => 'd', 'clubs' => 'c' }
    suits[suit]
  end
end
