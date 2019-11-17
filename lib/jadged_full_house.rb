class JadgedFullHouse < JadgedHand
  attr_reader :role_numbers, :kicker

  def initialize(role_numbers, kicker)
    @role = FULL_HOUSE
    @role_numbers = role_numbers
    @kicker = kicker
  end
end
