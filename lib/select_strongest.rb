class SelectStrongest
  attr_reader :role_and_hands, :main_role

  def initialize(role_and_hands)
    @role_and_hands = role_and_hands
    @main_role = role_and_hands[0][:role]
  end

  def execute
    numbers = []
    role_and_hands.each do |rah|
      case main_role
      when 1 then numbers << extract_one_pair_number(rah[:hand])
      end


    end
  end

  private

  def strongest_one_pair

  end

  def extract_one_pair_number(hand)
    number = nil
    hand.combination(2) do |a, b|
      number = a.number if a.number == b.number
    end
    number
  end
end
