class JadgedOnePair < JadgedHand
  def initialize(role_numbers, kickers)
    @role = ONE_PAIR
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
