module Web
  module Controllers
    module Qualify
      class Index
        include Web::Action

        expose :bord, :hands

        def call(params)
          deck = create_deck
          deck.shuffle!
          @bord = deck[0..4]
          @hands = [deck[5..6], deck[7..8]]
        end

        private

        def create_deck
          deck = []
          %w[spades hearts clubs diams].each do |suit|
            %w[a 2 3 4 5 6 7 8 9 10 j q k].each do |num|
              deck << { num: num, suit: suit }
            end
          end
          deck
        end
      end
    end
  end
end
