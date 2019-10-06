module Web
  module Controllers
    module Qualify
      class Create
        include Web::Action

        expose :param, :bord, :hands

        def call(params)
          puts params
          @param = params
          @bord = bord
          @hands = hands
        end

        private

        def bord
          b = []
          params[:bord].each_value do |card|
            suit, num = card.split('.')
            b << { num: num, suit: suit }
          end
          b
        end

        def hands
          hs = []
          params[:hand].sort.each do |hand_set|
            h = []
            hand_set.last.each_value do |card|
              suit, num = card.split('.')
              h << { num: num, suit: suit }
            end
            hs << h
          end
          hs
        end
      end
    end
  end
end
