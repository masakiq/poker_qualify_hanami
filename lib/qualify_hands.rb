class QualifyHands
  attr_reader :bord, :hands

  def initialize(bord, hands)
    @bord = ConvertBord.new(bord).run
    @hands = ConvertHands.new(hands).run
  end

  def execute
    first_player_hand = bord + hands[0]
    second_player_hand = bord + hands[1]
    return 0 if first_player_hand == second_player_hand
    first_player_hand > second_player_hand ? 1 : 2
  end
end
