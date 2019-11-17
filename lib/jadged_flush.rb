class JadgedFlush < JadgedHand
  # フラッシュは同じスートでの勝負となるので一番上のカードだけ保存する
  def initialize(role_numbers, kickers)
    @role = FLUSH
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
