class ExtractStrongestHand
  attr_reader :jadged_hands

  def initialize(jadged_hands)
    @jadged_hands = jadged_hands
  end

  def execute
    sorted = jadged_hands.sort {|a, b| a.role <=> b.role }
    strongest_role = sorted.last.role
    hands = jadged_hands.select {|j| j.role == strongest_role }
    return hands if hands.size == 1
    extract_strongest_on_same_role(hands)
  end

  private

  def extract_strongest_on_same_role(hands)
    case hands.first.role
    when JadgedHand::STRAIGHT_FLUSH then strongest_straight_flush(hands)
    when JadgedHand::FOUR_OF_A_KIND then strongest_four_of_a_kind(hands)
    when JadgedHand::FULL_HOUSE then strongest_full_house(hands)
    when JadgedHand::FLUSH then strongest_flush(hands)
    when JadgedHand::STRAIGHT then strongest_straight(hands)
    when JadgedHand::THREE_OF_A_KIND then strongest_three_of_a_kind(hands)
    when JadgedHand::TWO_PAIR then strongest_two_pair(hands)
    when JadgedHand::ONE_PAIR then strongest_one_pair(hands)
    when JadgedHand::NO_PAIR then strongest_no_pair(hands)
    end
  end

  def strongest_straight_flush(hands)
    sorted = hands.sort {|a, b| a.role_numbers.first <=> b.role_numbers.first }
    return sorted.first if sorted.first.role_numbers.first == 1
    sorted.last
  end

  def strongest_four_of_a_kind(hands)
    sorted = hands.sort {|a, b| a.role_numbers.first <=> b.role_numbers.first }
    return sorted.first if sorted.first.kickers.first == 1
    sorted.last
  end

  def strongest_full_house(hands)
    # キッカーが Ace の場合
    ace_kicker_hands = hands.select do |h|
      h.kickers.first == 1
    end
    return ace_kicker_hands.first if ace_kicker_hands.size == 1
    if ace_kicker_hands.size >= 2
      sorted = ace_kicker_hands.sort {|a, b| a.two_cards <=> b.two_cards }
      strongest_two_cards = sorted.last.two_cards
      strongest_two_cards_hands = sorted.select do |s|
        s.two_cards == strongest_two_cards
      end
      return strongest_two_cards_hands.first if strongest_two_cards_hands.size == 1
      return strongest_two_cards_hands
    end

    # キッカーが Ace じゃない場合
    sorted = hands.sort {|a, b| a.kickers.first <=> b.kickers.first }
    strongest_kicker = sorted.last.kickers.first
    strongest_role_hands = hands.select {|h| h.kickers.first == strongest_kicker }
    return strongest_role_hands.first if strongest_role_hands.size == 1
  end
end
