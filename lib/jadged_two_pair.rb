class JadgedTwoPair < JadgedHand
  def initialize(role_numbers, kickers)
    @role = TWO_PAIR
    @role_numbers = role_numbers
    @kickers = kickers
  end

  def strongest_role_number
    return @strongest_role_number if @strongest_role_number
    return @strongest_role_number = 1 if role_numbers.any? {|n| n == 1 }
    @strongest_role_number = role_numbers.sort.last
  end

  def weakest_role_number
    @weakest_role_number ||= role_numbers.reject {|n| n == strongest_role_number }.first
  end
end
