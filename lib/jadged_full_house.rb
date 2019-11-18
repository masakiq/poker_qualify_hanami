class JadgedFullHouse < JadgedHand
  attr_reader :tow_cards
  # 3 枚のほうのナンバーが kickers に入る
  def initialize(role_numbers, kickers, two_cards)
    @role = FULL_HOUSE
    @role_numbers = role_numbers
    @kickers = kickers
    # 2 枚のほうのナンバー
    @two_cards = two_cards
  end
end
