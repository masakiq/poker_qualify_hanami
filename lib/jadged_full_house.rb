class JadgedFullHouse < JadgedHand
  # 3 枚のほうのナンバーが kickers に入る
  def initialize(role_numbers, kickers)
    @role = FULL_HOUSE
    @role_numbers = role_numbers
    @kickers = kickers
  end
end
