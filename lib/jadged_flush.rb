class JadgedFlush < JadgedHand
  attr_reader :role_number, :kicker

  def initialize(role_number, kicker)
    @role = FLUSH
    @role_number = role_number
    @kicker = kicker
  end
end
