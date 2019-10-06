class Card
  class CardInvalidError < StandardError; end

  attr_reader :number, :suit

  def initialize(number, suit)
    @number = number.to_i
    @suit   = suit
    check_number
    check_suit
  end

  private

  def check_number
    raise CardInvalidError, "number:#{number}" unless [*(1..13)].include?(number)
  end

  def check_suit
    raise CardInvalidError, "suit:#{suit}" unless %w[s h d c].include?(suit)
  end
end
