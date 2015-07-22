module Analytical
	require "./dice.rb"

	class Analytical
		def initialize()
			@witness = 0
			@dice = 5
			@clues = 1
			@hand = []
			@total = 0
			@power_switch = true
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
		def set_witness(roll)
			@witness = roll
		end
		def win()
			@clues += @hand.count
			puts "You win and gain #{@hand.count} clues!"
		end
		############################
		#   reset functions
		############################
		def round_reset()
			@power_switch = true
			@dice = 5
			@total = 0
			@hand = []
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
				print "Rolled a #{die_roll}. You now have #{@total} total.\n"
				gets.chomp
			end
			return @total
		end

		############################
		#   reroll function
		############################
		def reroll(freebie)
			if freebie == true
				self.roll(1)
				self.roll_eval()
			else
				@clues -= 1
				self.roll(1)
				self.roll_eval()
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
			else 
				self.power()
			end
		end

		def bust()
			print "\nYou busted and lost two clues."
			gets.chomp
			if @clues >= 2
				@clues -= 2
			else 
				@clues = 0
			end
		end

		def spot_on()
			puts "\nYou matched the witness exactly! You instantly gained a clue!"
			@clues += 1
			puts "You now have #{@clues} clues."
		end

		def power()
			# reroll tokens
			token = false
			free = false

			if (@power_switch == true) && (@dice > 0)
				print "\nYou're Analytical, so you can roll an extra die for free. "
				answer = "nothing"
				until (answer == "Y") || (answer == "N")
					print "Do you want to roll your free die? (Y/N): "
					answer = gets.chomp.upcase
				end
				if answer == "Y"
					# this ensures reroll occurs, but no 
					# clue is subtracted in reroll()
					@power_switch = false
					token = true
					free = true
				else
					# breaking out of power checking loop
				end

			elsif (@power_switch == false) && (@dice > 0) && (@clues > 0)
				pay = "unsure"
				until (pay == "Y") || (pay == "N")
					puts "\nRemaining clues: #{@clues}"
					puts "Remaining dice: #{@dice}"
					puts "\nCurrent total: #{@total}."
					puts "Witness value: #{@witness}."
				   	puts "\nWould you like to expend a clue to roll another die? (Y/N): "
					pay = gets.chomp.upcase
				end
				# returning TRUE/FALSE to ok() call
				if pay == "Y"
					token = true
					free = false
				else 
					puts "Okay, so you're ending your investigation with a total of #{@total}."
					gets.chomp
				end
					# handling case where player has no dice to expend
			else
				puts "Dice remaining: #{@dice} | Clues remaining: #{@clues}"
				print "You can't afford to reroll, so you're ending your investigation at #{@total}."
				gets.chomp

			end

			if token == true
				self.reroll(free)
			else
			end
		end
	end 	# ends analytical

end
