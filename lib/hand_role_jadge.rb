class HandRoleJadge
  class NumberOfCardInvalidError < StandardError; end

  NO_PAIR = 0
  ONE_PAIR = 1
  TWO_PAIR = 2
  THREE_OF_A_KIND = 3
  STRAIGHT = 4
  FLUSH = 5
  FULL_HOUSE = 6
  FOUR_OF_A_KIND = 7
  STRAIGHT_FLUSH = 8

  attr_reader :cards, :jadged_hand

  def initialize(cards)
    raise NumberOfCardInvalidError if cards.size != 5
    @cards = cards
  end

  def execute
    return STRAIGHT_FLUSH if straight_flush?
    return FOUR_OF_A_KIND if four_of_a_kind?
    return FULL_HOUSE if full_house?
    return FLUSH if flush?
    return STRAIGHT if straight?
    return THREE_OF_A_KIND if three_of_a_kind?
    return TWO_PAIR if two_pair?
    return if one_pair?
    NO_PAIR
  end

  private

  # 2ペア、3カード、フルハウス、4カード含む
  def one_pair?
    number = 0
    cards.combination(2) do |a, b|
      number = a.number if a.number == b.number
    end
    return false if number == 0
    kickers = []
    cards.each do |card|
      kickers << if number != card.number
    end
    @jadged_hand = JadgedOnePair.new(number, kickers)
    true
  end

  # フルハウス、4カード含む
  def two_pair?
    numbers = []
    cards.combination(2) do |a, b|
      if a.number == b.number
        numbers << a.number
        rest = cards.reject {|card| card.same?(a) || card.same?(b) }
        rest.combination(2) do |c, d|
          if c.number == d.number
            numbers << c.number
          end
        end
      end
    end
    numbers.uniq!
    return false if numbers.size != 2
    kicker = 0
    cards.each do |card|
      kicker = card.number unless numbers.include?(card.number)
    end
    @role = JadgedTwoPair.new(numbers, kicker)
    true
  end

  # フルハウス含む
  def three_of_a_kind?
    role_number = 0
    cards.combination(3) do |a, b, c|
      role_number = a.number if a.number == b.number && b.number == c.number
    end
    return false if role_number == 0
    kickers = []
    cards.each do |card|
      kickers << card.number unless card.number != role_number
    end
    @jadged_hand = JadgedThreeOfAKind.new(role_number, kickers)
    true
  end

  # ストレートフラッシュ含む
  def straight?
    role_number = 0
    kicker = 0

    sorted = cards.sort {|a, b| a.number <=> b.number }
    if sorted.map(&:number) == [1, 10, 11, 12, 13]
      role_number = 1
      kicker = 1
    end
    return false if role_number == 1

    s = true
    base = sorted[0].number
    sorted.each_with_index do |card, index|
      s = false if card.number != (base + index)
    end
    return false unless s
    role_number = sorted.last.number
    kicker = sorted.last.number
    @jadged_hand = JadgedStraight.new(role_number, kicker)
    true
  end

  # ストレートフラッシュ含む
  def flush?
    cards[0].suit == cards[1].suit && cards[0].suit == cards[2].suit && cards[0].suit == cards[3].suit && cards[0].suit == cards[4].suit
  end

  def full_house?
    cards.combination(3) do |a, b, c|
      if a.number == b.number && b.number == c.number
        rest = cards.reject {|card| card.same?(a) || card.same?(b) || card.same?(c) }
        return true if rest[0].number == rest[1].number
      end
    end
    false
  end

  def four_of_a_kind?
    cards.combination(4) do |a, b, c, d|
      return true if a.number == b.number && b.number == c.number && c.number == d.number
    end
    false
  end

  def straight_flush?
    straight? && flush?
  end
end
