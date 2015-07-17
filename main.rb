require "./analytical.rb"
require "./professional.rb"
require "./cpu.rb"
require "./dice.rb"
require "./config.rb"
config = Config::Setup.new

print """
#####################
#                   #
#    Private Die    #
#                   #
#####################

by Mystic Ape Games
"""

# Main game loop
game = true

	################
	# Setup Stuff
	################

# asking about rules
config.rules()

# getting player character
player_char = config.char_selection()

# instantiating the cpu 
cpu = CPU::CPU.new

# instantiating the player's class 
if player_char == 1
	player = Analytical::Analytical.new
elsif player_char == 2
	player = Characters::Insubordinate.new
elsif player_char == 3
	player = Professional::Professional.new
	professional = true
elsif player_char == 4
	player = Characters::Lucky.new
elsif player_char == 5
	player = Characters::Indecisive.new
elsif player_char == 6
	player = Characters::Competitive.new
else
	puts "Player character unable to be instantiated for some reason."
	exit()
end

while game == true

	# instantiating the witness die
	witness_die = Dice::WitnessDie.new

	# resetting cpu variables
	cpu.round_reset()

	# resetting player variables
	player.round_reset()

	# rolling the witness die
	puts "\nHit ENTER to roll the witness die..."
	gets.chomp
	witness_roll = witness_die.roll()
	player.set_witness(witness_roll)

	# announcing witness
	puts "The witness roll is a #{witness_roll}."
	gets.chomp

	# accounting for professional
	if professional == true
		pro_choice = 0
		puts "As a professional, you may place your first die on a 1 or a 6."
		gets.chomp()
		until (pro_choice == 1) || (pro_choice == 6) do
			print "Do you want to start with a 1 or a 6?: "
			pro_choice = gets.chomp.to_i
			print "\n"
		end
		player.power(pro_choice)
	end

	# asking how many dice to roll
	how_many_dice = 100
	until (how_many_dice <= player.dice) && (how_many_dice >= 1) do
		puts "You have #{player.dice()} dice."
		print "How many dice do you want to roll?: "
		how_many_dice = gets.chomp.to_i
		print "\n"
	end
	
	# rolling the dice
	player_hand = player.roll(how_many_dice)

	# evaluating roll
	player.roll_eval()

	# playing CPU's turn
	result = cpu.play(witness_roll)
	
	# finding winner of the round
	# fetching totals
	player_total = player.total()
	cpu_total = cpu.total()
	# passing totals to cpu.find_winner()
	winner = cpu.find_winner(witness_roll, player_total, cpu_total)

	gets.chomp

	if winner == "player"
		player.win()
		gets.chomp

	elsif winner == "cpu"
		cpu.win()
		gets.chomp

	elsif winner == "none"
		puts "You both busted. No one wins!"
		gets.chomp

	else
		puts "It's a tie! No one gets anything!"
		gets.chomp
	end

	puts "\nThat's the end of the round!"
	gets.chomp

	#checking for a game winner
	player_clues = player.clues()
	cpu_clues = cpu.clues()

	puts "You have #{player_clues}, and your opponent has #{cpu_clues}."
	gets.chomp

	if player_clues >= 15
		puts "You win with #{player_clues} clues!"
		exit()
	elsif cpu_clues >= 15
		puts "Your opponent has solved the case with #{cpu_clues} clues! You lose!"
		exit()
	else
		# keep going
	end


# game kill switch for debugging
#exit()

end
