module Lucky
	require "./dice.rb"

	class Lucky
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
				self.play_on()
			end
		end

		def bust()
			puts "You busted, but you're lucky... flip a coin to determine your fate."
			gets.chomp
			flip = rand(0..1)
			if flip == 0
				puts "Heads! It's your lucky day! Gain 1 clue!"
				@clues += 1
			else
				puts "Tails! You avoid losing any clues for busting!"
			end
			gets.chomp
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
