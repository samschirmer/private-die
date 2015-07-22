module CPU
	require "./dice.rb"

	class CPU
		def initialize()
			@witness = 0
			@dice = 5
			@clues = 1
			@hand = []
			@total = 0
		end

		############################
		#   variable call functions
		############################
		def dice()
			return @dice
		end
		def clues()
			return @clues
		end
		def hand()
			return @hand.count
		end
		def total()
			return @total
		end
		def win()
			@clues += @hand.count
			puts "Your opponent wins and gains #{@hand.count} clues!"
		end
		############################
		#   reset functions
		############################
		def round_reset()
			@dice = 5
			@total = 0
			@hand = []
		end

		############################
		#   play function
		############################

		def play(roll)
			@witness = roll
			cpu_rolls = (@witness / 4).round

			# limiting CPU to 5 dice
			if cpu_rolls > 5
				cpu_rolls = 5
			end

			if (@clues > 1) || (@clues == 0)
				puts "\nThe witness is a #{@witness} and your opponent has #{@clues} clues."
			else
				puts "\nThe witness is a #{@witness} and your opponent has #{@clues} clue."
			end
			gets.chomp

			if cpu_rolls > 1
				puts "\nYour opponent rolls #{cpu_rolls} dice."
			else
				puts "\nYour opponent rolls #{cpu_rolls} die."
			end
			
			total = self.roll(cpu_rolls)

			self.roll_eval()
		end

		############################
		#   main roll function
		############################
		def roll(num)
			# rolling the dice
			for i in (0...num)
				die_roll = rand(1..6)
				# subtracting the die from the reserve
				@dice -= 1
				# totalling the rolls
				@total += die_roll
				# pushing roll values into hand[]
				@hand.push(die_roll)
				print "\nRolled a #{die_roll}. Opponent now has #{@total} total."
				gets.chomp
			end
			return @total
		end

		############################
		#   reroll function
		############################
		def reroll()
			if (@dice > 0) && (@clues > 0)
				@clues -= 1
				puts "Your opponent is paying a clue to roll an extra die."
				self.roll(1)
				self.roll_eval()
			else
				puts "Your opponent cannot reroll right now. She has #{@dice} dice and #{@clues} clues.."
			end
		end

		############################
		#   evaluation functions
		############################
		def roll_eval()
			if @total > @witness
				self.bust()
			elsif @total == @witness
				self.spot_on()
			elsif @witness - @total > 3
				self.reroll()
			else
				puts "Your opponent is ending her investigation at #{@total}, and she has #{@clues} clues remaining."
			end
		end

		def bust()
			if @clues >= 2
				@clues -= 2
			else 
				@clues = 0
			end
			print "\nYour opponent busted and lost two clues. She has #{@clues} clues remaining."
		end

		def spot_on()
			puts "\nYour opponent matched the witness exactly and gained a clue!"
			@clues += 1
		end

		####################################
		#   finding winner of the round
		####################################
		def find_winner(witness, player, cpu)
			if ((player > witness) && (cpu <= witness))
				return "cpu"
			
			elsif ((cpu > witness) && (player <= witness))
				return "player"
			
			elsif ((cpu > witness) && (player > witness))
				return "none"

			elsif (cpu == player)
				return "tie"

			elsif ((cpu > witness) && (player > witness))
				return "none"

			else
				if ((witness - player) > (witness - cpu))
					return "cpu"
				elsif ((witness - cpu) > (witness - player))
					return "player"
				else
					return "tie"
				end
			end
		end

	end 	# ends class

end
