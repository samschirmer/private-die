module Characters
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
		def dice
			return @dice
		end
		def clues
			return @clues
		end
		def set_witness(roll)
			@witness = roll
		end
		############################
		#   reset @power_switch
		############################
		def power_switch
			@power_switch = true
		end

		############################
		#   main roll function
		############################
		def roll(num)
			# rolling the dice
			for i in (0...num)
				die_roll = rand(1..6)
				print "Rolled a #{die_roll}."
				# subtracting the die from the reserve
				@dice -= 1
				# totalling the rolls
				@total += die_roll
				# pushing roll values into hand[]
				@hand.push(die_roll)
				gets.chomp
			end
			return @total
		end

		############################
		#   reroll function
		############################

		#TODO MAKE THIS MAKE SENSE; THIS IS HALF-DONE
		def reroll()
			@clues -= 1
			self.roll(1)
			self.roll_eval()
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
			if @clues >= 2
				@clues -= 2
			else 
				@clues = 0
			end
		end

		def spot_on()
			print "\nYou matched the witness exactly! You gained two clues!"
			@clues += @hand.count
		end

		def power()
			# reroll tokens
			token = false

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
				else
					# breaking out of power checking loop
				end

			elsif (@power_switch == false) && (@dice > 0) && (@clues > 0)
				pay = "unsure"
				until (pay == "Y") || (pay == "N")
				   	print "Would you like to expend a clue to roll another die? (Y/N): "
					pay = gets.chomp.upcase
				end
				# returning TRUE/FALSE to ok() call
				if pay == "Y"
					token = true
				else 
					puts "Okay, so you're ending your investigation."
					gets.chomp
				end
					# handling case where player has no dice to expend
			else
				print "You can't afford to reroll."
				gets.chomp

			end

			if token == true
				self.reroll()
			else
			end
		end
	end 	# ends analytical
	





	class Insubordinate
		def initialize()
			@dice = 4
			@clues = 1
		end

		def roll(num)
		end
	end
	
	class Professional
		def initialize()
			@dice = 5
			@clues = 1
		end

		def roll(num)
		end
	end
	
	class Lucky
		def initialize()
			@dice = 5
			@clues = 1
		end

		def roll(num)
		end
	end
	
	class Indecisive
		def initialize()
			@dice = 5
			@clues = 1
		end

		def roll(num)
		end
	end

	class Competitive
		def initialize()
			@dice = 5
			@clues = 1
		end

		def roll(num)
		end
	end

end
