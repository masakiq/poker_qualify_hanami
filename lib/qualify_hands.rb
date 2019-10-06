class QualifyHands
  def initialize(bord, hands)
    b = ConvertBord.new(bord).run
    h = ConvertHands.new(hands).run
  end
end
