class JadgeOf7Cards
  class NumberOfCardInvalidError < StandardError; end

  attr_reader :cards

  def initialize(cards)
    raise NumberOfCardInvalidError if cards.size != 7
    @cards = cards
  end

  def execute
    role_and_hands = []
    cards.combination(5) do |a, b, c, d, e|
      temp = [a, b, c, d, e]
      role_and_hands << [HandRoleJadge.new(temp).execute, temp]
    end
    role.sort.last
  end

  private

  def extract_same_roles(role_and_hands)
    strongest = role_and_hands.sort.last[0]
    strongest_hands = []
    role_and_hands.each do |rah|
      strongest_hands << { role: rah[0], hand: rah[1] } if rah[0] == strongest
    end
    strongest_hands
  end
end
