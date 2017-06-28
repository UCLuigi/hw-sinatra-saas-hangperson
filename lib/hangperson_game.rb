class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
    @num_wrong = 0
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri, {}).body
  end

  def guess(letter)
    raise ArgumentError if letter.nil?
    raise ArgumentError unless letter.downcase =~ /[a-z]/
    letter_l = letter.downcase
    if @guesses.include?(letter_l) || @wrong_guesses.include?(letter_l)
      @num_wrong += 1
      false
    elsif @word.include?(letter_l)
      @guesses += letter_l
    else
      @wrong_guesses += letter_l
      @num_wrong += 1
    end
  end

  def check_win_or_lose
    if @num_wrong == 7
      :lose
    elsif word_with_guesses == @word
      :win
    else
      :play
    end
  end

  def word_with_guesses
    if @guesses == ''
      @word.tr(@word, '-')
    else
      @word.gsub(Regexp.new('[^' + @guesses + ']'), '-')
    end
  end

end
