module Game_Config

	class Setup
		def rules()
			rules = "Q"
			while (rules != "Y") && (rules != "N")
				print "\nDo you want to read the rules? (Y/N): "
				rules = gets.chomp.upcase
			end

			if rules == "Y"
				txt = open("./rules.txt")
				print txt.read
				txt.close
				gets.chomp
			end
		end

		def char_selection()
			char = 69
			puts "\nChoose your character:"
			puts "\n1) Analytical - Once per round you may roll an additional die without spending a clue."
			puts "\n2) Insubordinate - At the beginning of the game, remove one of your dice and set it aside. This die may not be used for the duration of the game. You may re-roll one of your own die once per round."
			puts "\n3) Professional - Before you begin questioning, set one of your dice to a 1 or 6. This counts towards your investigation. Then decide how many more you want to roll."
			puts "\n4) Lucky - When you bust, roll a die. If the result is even, gain one clue instead of losing clues. If odd, lose one less clue."
			puts "\n5) Two-Faced - You have an extra die that counts as a negative. After completing your roll, you may roll this extra die for no cost, which will lower your total roll. If you win, you receive one less clue.."
			puts "\n6) Competitive - If you do not win the round, but you are within two of your opponent's total, you will challenge them to a winner-takes-all roll off, as if you had tied. If you bust, you still lose two clues, but you may still challenge your opponent if you're within two."

			until (char >= 1) && (char <= 6) do
				print "\n>> "
				char = gets.chomp.to_i
			end
			return char.round
		end

	end

end
