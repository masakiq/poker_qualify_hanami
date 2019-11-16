class JadgedTwoPair < JadgedHand
  attr_reader :role_numbers, :kicker

  def initialize(role_numbers, kicker)
    @role = TWO_PAIR
    @role_numbers = role_numbers
    @kicker = kicker
  end
end
