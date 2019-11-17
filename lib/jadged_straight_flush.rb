class JadgedStraightFlush < JadgedHand
  attr_reader :role_number, :kicker

  def initialize(role_number, kicker)
    @role = STRAIGHT_FLUSH
    @role_number = role_number
    @kicker = kicker
  end
end
