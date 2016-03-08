class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses=''
    @status = :play
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(str)
    
    raise ArgumentError if str.nil?
    raise ArgumentError if str.empty?
    raise ArgumentError if str =~ /[^a-zA-Z]+/
    
    str = str.downcase.split(//)
    
    str.each do |char|
      if (!@guesses.include? char) && (!@wrong_guesses.include? char)
        if @word.include? char
          @guesses << char
          @status = :win if !word_with_guesses.include?('-') && @status != :lose
          return true
        else 
          @wrong_guesses << char
          @status = :lose if @wrong_guesses.length >= 7
          return true
        end
      end
      return false
    end
  end
  
  def word_with_guesses
    return @word.gsub(Regexp.new(@guesses.empty? ? '.' : '[^'+@guesses+']', Regexp::IGNORECASE) , '-')
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def check_win_or_lose
    return @status
  end

end
