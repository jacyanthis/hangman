class Computer
  attr_accessor :dictionary, :word, :current_guess, :guessed_letters

  def initialize
    @dictionary = get_dictionary
    @word = nil
    @current_guess = nil
    @guessed_letters = []
  end

  def get_dictionary
    dictionary = []
    File.foreach('dictionary.txt') do |line|
      dictionary << line.chomp
    end

    dictionary
  end

  #these are checker methods

    def get_common_words
      #this file should probably store a hash if this program is used a lot
      File.foreach('most_common.txt') do |line|
        dictionary << line.chomp
      end
    end

    def get_word
     self.word = dictionary.sample
     self.current_guess = "_" * word.length
    end

    def guess_correct?(guess)
      letters = word.split(//)
      correct = false
      letters.each_with_index do |letter, index|
        if letter == guess
          current_guess[index] = letter
          correct = true
        end
      end
      puts current_guess

      correct
    end

    def won?
      word == current_guess
    end

    def write(answer)
    end


  #these are guesser methods

    def get_guess(opponents_feedback)
      puts "So far, the computer has guessed: #{guessed_letters}"
      eliminate_on_length(opponents_feedback.length)
      eliminate_on_positions(opponents_feedback)
      
      most_common_letter
    end

    def eliminate_on_length(number)
      self.dictionary = dictionary.select { |word| word.length == number }
    end

    def most_common_letter
      letters = get_unguessed_letters
      frequency = letters.inject(Hash.new(0)) { |freq, letter| freq[letter] += 1; freq }
      guess = letters.max_by { |value| frequency[value] }
      guessed_letters << guess
      puts "The computer is now guessing: #{guess}"

      guess
    end

    def get_unguessed_letters
      letters = dictionary.map { |word| word.split(//).uniq }.flatten
      guessed_letters.each { |letter| letters.delete(letter) }

      letters
    end

    def eliminate_on_positions(opponents_feedback)
      self.dictionary = dictionary.select do |word|
        position_match?(word, opponents_feedback)
      end
    end

    def position_match?(word, opponents_feedback)
      letters = word.split(//)
      letters.each_with_index do |letter, index|
        return false if opponents_feedback[index] != "_" && opponents_feedback[index] != letter
      end

      true
    end


end
