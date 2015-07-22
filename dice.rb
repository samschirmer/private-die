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

		def tie(player_hand, cpu_hand)
			player_total = 0
			cpu_total = 0
			winner = "wat"
			winner_found = false

			until winner_found == true do
				puts "\nYou rolled #{player_hand} and your opponent rolled #{cpu_hand}."
				gets.chomp
				
				# rolling hands
				for i in (0...player_hand)
					player_roll = rand(1..6)
					player_total += player_roll
					puts "You rolled a #{player_roll}."
				end
	
				puts "\nYour total hand after re-rolling is #{player_total}."
				gets.chomp
	
				for i in (0...cpu_hand)
					cpu_roll = rand(1..6)
					cpu_total += cpu_roll
					puts "Your opponent rolled a #{cpu_roll}."
				end
	
				puts "\nYour opponent's total roll is #{cpu_total}."
	
				if player_total > cpu_total
					winner = "player"
					winner_found = true
				elsif cpu_total > player_total
					winner = "cpu"
					winner_found = true
				else
					puts "\nYou're still tied! Roll again!"
					cpu_total = 0
					player_total = 0
					gets.chomp
				end
			end

			return winner

			
		end

	end
end
