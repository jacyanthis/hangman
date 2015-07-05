class Human
  attr_accessor :current_guess, :guessed_letters

  def initialize
    @current_guess = nil
    @guessed_letters = []
  end

  #these are checker methods

    def get_word
      puts "How many letters is your word?"
     chosen_word = gets.chomp
     until chosen_word.match(/\d/)
       puts "Please enter a number."
       chosen_word = gets.chomp
     end
     current_guess = "_" * chosen_word.to_i
    end

    def guess_correct?(guess)
      correct = false
     answer = get_user_feedback(guess)
     if answer != ["n"]
       correct = true
       answer.each do |number|
         current_guess[number.to_i - 1] = guess
       end
     end
     puts current_guess

     correct
    end

    def get_user_feedback(guess)
     puts "Checker, which positions does #{guess} match? (if none, enter 'n')"
     answer = gets.chomp.downcase.split(",")
     until answer == ["n"] || array_of_integers?(answer)
       puts "Sorry, I didn't understand. Please enter something like '1,2' or 'n'"
       answer = gets.chomp.downcase.split(",")
     end

     answer
    end

    def array_of_integers?(array)
     array.each { |element| return false unless element.match(/\d/) }

     true
    end

    def won?
      !current_guess.match(/_/)
    end

    def write(answer)
     File.open("most_common.txt", "a") { |f| f.puts answer }
    end

  #these are getter methods

    def get_guess(current_guess)
      puts "Guesser, so far, you have guessed: #{guessed_letters}"
      puts "Which letter would you like to guess?"
      guess = gets.chomp.downcase
      until guess.length == 1 && guess.match(/[a-z]/) && !guessed_letters.include?(guess)
        puts "Please enter a letter."
        guess = gets.chomp.downcase
      end
      guessed_letters << guess
      
      guess
    end

    def get_common_words
    end

end
