class HandRoleJadge
  class NumberOfCardInvalidError < StandardError; end
  attr_reader :cards, :jadged_hand

  def initialize(cards)
    raise NumberOfCardInvalidError if cards.size != 5
    @cards = cards
  end

  def execute
    return if straight_flush?
    return if four_of_a_kind?
    return if full_house?
    return if flush?
    return if straight?
    return if three_of_a_kind?
    return if two_pair?
    return if one_pair?
    create_no_pair
  end

  private

  def create_no_pair
    numbers = cards.map {|c| c.number }.sort.reverse
    @jadged_hand = JadgedNoPair.new([], numbers)
  end

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
    @jadged_hand = JadgedOnePair.new([number], kickers)
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
    @role = JadgedTwoPair.new(numbers, [kicker])
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
    @jadged_hand = JadgedThreeOfAKind.new([role_number], kickers)
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
    @jadged_hand = JadgedStraight.new([role_number], [kicker])
    true
  end

  # ストレートフラッシュ含む
  def flush?
    return false unless cards[0].suit == cards[1].suit && cards[0].suit == cards[2].suit && cards[0].suit == cards[3].suit && cards[0].suit == cards[4].suit
    role_number = cards.map {|c| c.number }.sort.last
    @jadged_hand = JadgedFlush.new([role_number], [role_number])
    true
  end

  def full_house?
    role_numbers = []
    kicker = 0
    cards.combination(3) do |a, b, c|
      if a.number == b.number && b.number == c.number
        role_numbers << a.number
        rest = cards.reject {|card| card.same?(a) || card.same?(b) || card.same?(c) }
        if rest[0].number == rest[1].number
          role_numbers << rest[0].number
          kicker = a.number
        end
      end
    end
    role_numbers.uniq!
    return false if role_numbers.size != 2
    @jadged_hand = JadgedFullHouse.new(role_numbers, [kicker])
    true
  end

  def four_of_a_kind?
    role_number = 0
    kicker = 0
    cards.combination(4) do |a, b, c, d|
      if a.number == b.number && b.number == c.number && c.number == d.number
        role_number = a.number
      end
    end
    return false if role_number == 0
    kicker = cards.reject {|c| c.number == role_number }.first.number
    @jadged_hand = JadgedFourOfAKind.new([role_number], [kicker])
    true
  end

  def straight_flush?
    return false unless flush? && straight?
    @jadged_hand = JadgedStraightFlush.new(jadged_hand.role_number, jadged_hand.kicker)
    true
  end
end
