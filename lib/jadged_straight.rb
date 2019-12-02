class JadgedStraight < JadgedHand
  # role_numbers には一番上のカードだけ入っている
  # ace の場合は 1 が入っている
  def initialize(role_numbers, kickers)
    @role = STRAIGHT
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
