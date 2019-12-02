class JadgedOnePair < JadgedHand
  def initialize(role_numbers, kickers)
    @role = ONE_PAIR
    @role_numbers = role_numbers
    @kickers = kickers
  end

  def sorted_kickers
    return @sorted_kickers if @sorted_kickers
    @sorted_kickers = @kickers.sort.reverse
    if @sorted_kickers.last == 1
      @sorted_kickers.delete(1)
      @sorted_kickers.insert(0, 1)
    end
    @sorted_kickers
  end
end
