class QualifyHands
  attr_reader :bord, :hands

  def initialize(bord, hands)
    @bord = ConvertBord.new(bord).run
    @hands = ConvertHands.new(hands).run
  end

  def execute
    first_player_cards = bord + hands[0]
    second_player_cards = bord + hands[1]
    first_player_result = JadgeOf7Cards.new(first_player_cards).execute
    second_player_result = JadgeOf7Cards.new(second_player_cards).execute
    result = ExtractStrongestHand.new([first_player_result, second_player_result]).execute
    return 0 if result.is_a?(Array)
    first_player_result.same?(result) ? 1 : 2
  end
end
