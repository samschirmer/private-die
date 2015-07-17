module Config

	class Setup
		def rules()
			rules = "Q"
			while (rules != "Y") && (rules != "N")
				print "\nDo you want to read the rules? (Y/N): "
				rules = gets.chomp.upcase
			end

			if rules == "Y"
				#print rulebook here
			end
		end

		def char_selection()
			char = 69
			puts "\nThis is an extremely pre-alpha version of this game, so your character choices are limited."
			puts "\n1) Analytical - Once per round you may roll an additional die without spending a clue."
			puts "\n2) Insubordinate - At the beginning of the game, remove one of your dice and set it aside. This die may not be used for the duration of the game. You may re-roll one of your own die once per round."
			puts "\n3) Professional - Before you begin questioning, set one of your dice to a 1 or 6. This counts towards your investigation. Then decide how many more you want to roll."
			puts "\n4) Lucky - When you bust, roll a die. If the result is even, gain one clue instead of losing clues. If odd, lose one less clue."
			puts "\n5) Indecisive - Once per round, you may change the face of your lowest die to the opposite side. If this causes you to match the witness die, do not gain a bonus clue."
			puts "\n6) Competitive - At the beginning of your turn if you are at least two clues behind the detective with the most clues, gain a clue. Otherwise, choose a detective with less clues than you to gain a clue."

			until (char >= 1) && (char <= 6) do
				print "\n>> "
				char = gets.chomp.to_i
			end
			return char.round
		end

	end

end
