class JadgeOf7Cards
  class NumberOfCardInvalidError < StandardError; end

  attr_reader :cards

  def initialize(cards)
    raise NumberOfCardInvalidError if cards.size != 7
    @cards = cards
  end

  def execute
    roles = []
    cards.combination(5) do |a, b, c, d, e|
      temp = [a, b, c, d, e]
      roles << HandRoleJadge.new(temp).execute
    end
    roles.sort.last
  end
end
