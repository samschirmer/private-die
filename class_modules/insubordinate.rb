module Insubordinate
	require "./dice.rb"

	class Insubordinate
		def initialize()
			@witness = 0
			@dice = 4
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
			@dice = 4
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
		def power()
			reroll = "Q"
			until (reroll == "Y") || (reroll == "N")
			   	puts "\nWould you like to reroll one of your dice? (Y/N): "
				reroll = gets.chomp.upcase
			end

			if reroll == "Y"
				puts "\nYour current roll:"
				for i in (0...@hand.count)
					puts "#{i+1}. #{@hand[i]}"
				end
				num = 100
				until (num >= 1) && (num <= @hand.count)
					print "\nWhich would you like to reroll? [1-#{@hand.count}]: "
					num = gets.chomp.to_i
				end

				# rolling for new number
				new_num = rand(1..6)
				puts "You rerolled your #{@hand[num - 1]} and got a #{new_num}."

				# subtracting old value from @total and adding new value
				@total -= @hand[num-1]
				@total += new_num

				# replacing chosen value in @hand with the new roll
				@hand[num - 1] = new_num

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
			print "\nYou busted and lost two clues."
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
