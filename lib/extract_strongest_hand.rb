class ExtractStrongestHand
  attr_reader :jadged_hands

  def initialize(jadged_hands)
    @jadged_hands = jadged_hands
  end

  def execute
    sorted = jadged_hands.sort {|a, b| a.role <=> b.role }
    strongest_role = sorted.last.role
    hands = jadged_hands.select {|j| j.role == strongest_role }
    return hands.first if hands.size == 1
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
    three_card_list = hands.map {|h| h.three_card }
    three_index_list = which_is_strong(three_card_list)
    return hands[three_index_list] if three_index_list.size == 1

    two_card_list = hands.map {|h| h.two_card }
    two_index_list = which_is_strong(two_card_list)
    return hands[two_index_list] if two_index_list.size == 1

    merged_index_list = three_index_list & two_index_list
    strongest_hands = []
    merged_index_list.each do |i|
      strongest_hand << hands[i]
    end
    strongest_hands
  end

  def strongest_flush(hands)
    sorted = hands.sort {|a, b| a.role_numbers.sum <=> b.role_numbers.sum }
    strongest_sum = sorted.last.role_numbers.sum
    strongest_hands = sorted.select {|s| s.role_numbers.sum == strongest_sum }
    return strongest_hands.first if strongest_hands.size == 1
    strongest_hands
  end

  def strongest_straight(hands)
    sorted = hands.sort {|a, b| a.role_numbers.first <=> b.role_numbers.first }
    return sorted.first if sorted.first.role_numbers.first == 1
    sorted.last
  end

  def strongest_three_of_a_kind(hands)
    # キッカーが Ace の場合
    ace_role_hands = hands.select {|h| h.role_numbers.first == 1 }
    return ace_role_hands.first if ace_role_hands.size == 1
    if ace_role_hands.size >= 2
      sorted = ace_role_hands.sort {|a, b| a.kickers.sum <=> b.kickers.sum }
      strongest_kickers_sum = sorted.last.kickers.sum
      strongest_kickers_sum_hands = sorted.select do |s|
        s.kickers.sum == strongest_kickers_sum
      end
      return strongest_kickers_sum_hands.first if strongest_kickers_sum_hands.size == 1
      return strongest_kickers_sum_hands
    end
  end

  def strongest_two_pair(hands)
    strongest_role_numbers = hands.map {|h| h.strongest_role_number }

    index_list = which_is_strong(strongest_role_numbers)
    return hands[index_list.first] if index_list.size == 1

    strongest_role_hands = []
    index_list.each do |i|
      strongest_role_hands << hands[i]
    end

    weakest_role_numbers = strongest_role_hands.map {|h| h.weakest_role_number }

    index_list = which_is_strong(weakest_role_numbers)
    return strongest_role_hands[index_list.first] if index_list.size == 1

    weakest_role_hands = []
    index_list.each do |i|
      weakest_role_hands << strongest_role_hands[i]
    end

    kickers = weakest_role_hands.map {|h| h.kickers.first }

    index_list = which_is_strong(kickers)
    return weakest_role_hands[index_list.first] if index_list.size == 1

    kicker_role_hands = []
    index_list.each do |i|
      kicker_role_hands << weakest_role_hands[i]
    end

    kicker_role_hands
  end

  def strongest_one_pair(hands)
    role_numbers = hands.map {|h| h.role_numbers.first }

    index_list = which_is_strong(role_numbers)
    return hands[index_list.first] if index_list.size == 1

    same_role_hands = []
    index_list.each do |i|
      same_role_hands << hands[i]
    end

    (0..2).each do |i|
      kickers = same_role_hands.map {|h| h.sorted_kickers[i] }
      index_list = which_is_strong(kickers)
      return same_role_hands[index_list.first] if index_list.size == 1

      role_hands = []
      index_list.each do |t|
        role_hands << same_role_hands[t]
      end

      same_role_hands = role_hands
    end

    same_role_hands
  end

  def strongest_no_pair(hands)
    role_hands = hands
    (0..4).each do |i|
      kickers = role_hands.map {|h| h.sorted_kickers[i] }
      index_list = which_is_strong(kickers)
      return role_hands[index_list.first] if index_list.size == 1

      old_role_hands = role_hands.dup
      role_hands = []
      index_list.each do |t|
        role_hands << old_role_hands[t]
      end
    end

    role_hands
  end

  # @return [Array<Integer>] Index numbers
  #   e.x. [2, 5, ...]
  def which_is_strong(numbers)
    ace_index_list = []
    numbers.each_with_index do |n, i|
      ace_index_list << i if n == 1
    end
    return ace_index_list if ace_index_list.size > 0

    strong_number = numbers.sort.last
    index_list = []
    numbers.each_with_index do |n, i|
      index_list << i if n == strong_number
    end
    index_list
  end
end
