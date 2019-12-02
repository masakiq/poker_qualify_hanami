require_relative './jadged_hand.rb'

class JadgedFlush < JadgedHand
  # 5 枚のカードナンバーすべてが保存される。
  # role_numbers と kickers の中身は同じ
  # ace は 14 に変換されている。
  # 強さは合計値の高いほうとなる。
  def initialize(role_numbers, kickers)
    @role = FLUSH
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
