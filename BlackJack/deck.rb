require_relative 'card.rb'

class Deck

  attr_reader :cards

  def create_deck
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value, point|
        @cards << Card.new(suit, value, point)
      end
    end
    @cards.shuffle!
  end

  def give_card
    @cards.shift
  end
end
