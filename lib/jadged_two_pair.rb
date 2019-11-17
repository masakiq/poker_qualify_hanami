class JadgedTwoPair < JadgedHand
  def initialize(role_numbers, kickers)
    @role = TWO_PAIR
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
