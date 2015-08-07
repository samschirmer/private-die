module TwoFaced
	require "./dice.rb"

	class TwoFaced
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
		def get_power()
			return @power_switch
		end
		def win()
			@clues += @hand.count
			puts "You win and gain #{(@hand.count - 1)} clues!"
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
				# totaling the rolls
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
		def reroll()
			@clues -= 1
			self.roll(1)
			self.roll_eval()
		end

		############################
		#   evaluation functions
		############################
		def power()
			negroll = "Q"
			until (negroll == "Y") || (negroll == "N")
			   	print "\nWould you like to roll your negative die? (Y/N): "
				negroll = gets.chomp.upcase
			end

			if negroll == "Y"
				@power_switch = false

				# rolling for new number
				new_num = rand(1..6)
				puts "You rolled your negative die and got a #{new_num}."

				# subtracting old value from @total and adding new value
				@total -= new_num

				puts "You now have a total of #{@total}."
				gets.chomp

				self.roll_eval()
			else
				self.roll_eval()
			end
		end

		def roll_eval()
			if @total > @witness
				self.bust()
			elsif @total == @witness
				self.spot_on()
			else 
				self.play_on()
			end
		end

		def bust()
			if @power_switch == true
				print "\nYou busted, but you can still lower your total."
				gets.chomp
				self.power()
			else
				print "\nYou busted and lost two clues."
				gets.chomp
				if @clues >= 2
					@clues -= 2
				else 
					@clues = 0
				end
			end
		end

		def spot_on()
			puts "\nYou matched the witness exactly! You instantly gained a clue!"
			@clues += 1
			puts "You now have #{@clues} clues."
		end

		def play_on()
			# reroll tokens
			token = false

			if (@dice > 0) && (@clues > 0)
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
				self.reroll()
			else
			end
		end
	end 	# ends class

end
