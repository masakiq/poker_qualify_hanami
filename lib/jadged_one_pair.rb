class JadgedOnePair < JadgedHand
  attr_reader :role_number, :kickers

  def initialize(role_number, kickers)
    @role = ONE_PAIR
    @role_number = role_number
    @kickers = kickers
  end
end
