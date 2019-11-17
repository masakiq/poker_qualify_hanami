class JadgedNoPair < JadgedHand
  def initialize(role_numbers, kickers)
    @role = NO_PAIR
    @role_numbers = []
    @kickers = kickers
  end
end
