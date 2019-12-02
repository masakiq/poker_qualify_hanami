class JadgedFullHouse < JadgedHand
  attr_reader :three_card, :tow_card
  # 3 枚のほうのナンバーが kickers に入る
  def initialize(role_numbers, kickers, three_card, two_card)
    @role = FULL_HOUSE
    @role_numbers = role_numbers
    @kickers = []
    @three_card = three_card
    @two_card = two_card
  end
end
