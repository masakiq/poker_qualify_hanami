class JadgedStraightFlush < JadgedHand
  def initialize(role_numbers, kickers)
    @role = STRAIGHT_FLUSH
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
