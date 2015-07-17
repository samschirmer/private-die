module Dice
	class WitnessDie
		@value = 0

		def initialize()
			sides = 12
		end

		def get_value()
			return @value
		end

		def roll()
			@value = rand(7..21)
			return @value
		end

		def evaluate(witness_roll, player_hand)
			if witness_roll < player_hand
				return "bust"
			elsif witness_roll == player_hand
				return "spot-on"
			elsif witness_roll > player_hand
				return "ok"
			end
		end

	end
end
