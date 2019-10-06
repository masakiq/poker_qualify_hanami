class Converts
  def self.convert_num(num)
    highs = { 'a' => 1, 'j' => 11, 'q' => 12, 'k' => 13 }
    n = highs[num]
    n ? n : num.to_i
  end

  def self.convert_suit(suit)
    suits = { 'hearts' => 'h', 'spades' => 's', 'diams' => 'd', 'clubs' => 'c' }
    suits[suit]
  end
end
