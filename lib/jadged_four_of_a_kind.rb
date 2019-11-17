class JadgedFourOfAKind < JadgedHand
  attr_reader :role_number, :kicker

  def initialize(role_number, kicker)
    @role = FOUR_OF_A_KIND
    @role_number = role_number
    @kicker = kicker
  end
end
