class JadgedNoPair < JadgedHand
  attr_reader :role_number, :kickers

  def initialize(role_number, kickers)
    @role = NO_PAIR
    @role_number = nil
    @kickers = kickers
  end
end
