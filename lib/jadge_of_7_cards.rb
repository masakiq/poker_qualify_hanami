class JadgeOf7Cards
  class NumberOfCardInvalidError < StandardError; end

  attr_reader :cards

  def initialize(cards)
    raise NumberOfCardInvalidError if cards.size != 7
    @cards = cards
  end

  def execute
    jadged_hands = []
    cards.combination(5) do |a, b, c, d, e|
      temp = [a, b, c, d, e]
      jadged_hands << HandRoleJadge.new(temp).execute.jadged_hand
    end
    ExtractStrongestHand.new(jadged_hands).execute
  end
end
