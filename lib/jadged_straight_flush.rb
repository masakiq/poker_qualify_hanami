class JadgedStraightFlush < JadgedHand
  # role_numbers と kickers には一番上のキッカーだけが入る。
  def initialize(role_numbers, kickers)
    @role = STRAIGHT_FLUSH
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
