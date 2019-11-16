class JadgedThreeOfAKind < JadgedHand
  attr_reader :role_numbers, :kickers

  def initialize(role_numbers, kickers)
    @role = THREE_OF_A_KIND
    @role_numbers = role_numbers
    @kickers = kickers
  end
end