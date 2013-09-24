# Austin Longo
# 09/11/13
# Git Link: https://github.com/Forerunner117/CSCI_3308/blob/master/labs/lab2/Lab2.rb

# Part1: Hello World
class HelloWorldClass
    def initialize(name)
       @name = name.capitalize
    end
    def sayHi
        puts "Hello #{@name}!"
    end
end
#hello = HelloWorldClass.new("austin")
#hello.sayHi


#********************************************************
# Part2: Strings

#a) Palindromes

def palindrome?(string)
	string.downcase!
	string.gsub!(/\W+/, '')
	puts string
	if string === string.reverse
		puts "true"
	else
		puts "false"
	end
end
"A man, a plan, a canal -- Panama".palindrome?

palindrome?("A man, a plan, a canal -- Panama")
palindrome?("Madam, I'm Adam!")

#b) Word Count

def count_words(string)
	string.downcase!
	string.gsub!("'", '')
	string.gsub!(/\W+/, ' ')
	strings = string.split(/\b/)
	puts string
	wordHash = Hash.new

	strings.each do |word|
		if wordHash.has_key?(word)
			wordHash[word] += 1
		elsif word === " "
			#do nothing
		else 
			wordHash[word] = 1
		end 
	end

	puts wordHash
end

#count_words("A man, a plan, a canal -- Panama")
#count_words("Madam, I'm Adam!")


#********************************************************
# Part3: Rock Paper Scissors

#a) rps_game_winner

class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2

    player1 = game[0][0]
    player1Move = game[0][1]
    player2 = game[1][0]
    player2Move = game[1][1]

    puts player1 + ", " + player1Move, player2 + ", " + player2Move

    raise NoSuchStrategyError unless 
    player1Move =~ /R|P|S/ && player2Move =~ /R|P|S/

    if player1Move =~ /R/ && player2Move =~ /S/
    	puts player1 + " Wins!"
    	game[0]
    elsif player1Move =~ /R/ && player2Move =~ /P/
  		puts player2 + " Wins!"
  		game[1]
  	elsif player1Move =~ /R/ && player2Move =~ /R/
  		puts player1 + " Wins!"
  		game[0]
  	elsif player1Move =~ /P/ && player2Move =~ /S/
  		puts player2 + " Wins!"
  		game[1]
  	elsif player1Move =~ /P/ && player2Move =~ /P/
  		puts player1 + " Wins!"
  		game[0]
  	elsif player1Move =~ /P/ && player2Move =~ /R/
  		puts player1 + " Wins!"
  		game[0]
  	elsif player1Move =~ /S/ && player2Move =~ /S/
   		puts player1 + " Wins!"	
   		game[0]
  	elsif player1Move =~ /S/ && player2Move =~ /P/	
   		puts player1 + " Wins!"	 	
   		game[0]
  	elsif player1Move =~ /S/ && player2Move =~ /R/
  		puts player2 + " Wins!"
  		game[1]
  	end
  		
  	   	 	   	
  
end

rps_game_winner([ ["Armando", "R"], ["Dave", "S"] ])



def rps_tournament_winner(tourney)
    # Check if we're at a game
    if tourney[0][0].is_a? String
        return rps_game_winner(tourney)
    end
    # Otherwise keep going down the rabbit hole
    return rps_game_winner([rps_tournament_winner(tourney[0]),rps_tournament_winner(tourney[1])])

end


rps_tournament_winner(
	[
    	[
        	[ ["Armando", "P"], ["Dave", "S"] ],
        	[ ["Richard", "R"],  ["Michael", "S"] ],
    	],
    	[
        	[ ["Allen", "S"], ["Omer", "P"] ],
        	[ ["David E.", "R"], ["Richard X.", "P"] ]
    	]
	]
)




#********************************************************
# Part4: Anagrams
def combine_anagrams(words)
	anagrams = words.group_by { |word| word.downcase.chars.sort }.values
	puts anagrams.to_s
end

combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])
