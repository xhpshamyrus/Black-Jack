require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'interface.rb'

class Player

  CASH = 100

  attr_reader :name, :cash, :hand

  def initialize(name)
    @name = name
    @cash = CASH
    @hand = Hand.new
  end

  def make_bet(value)
    @cash -= value
  end

  def add_cash(value)
    @cash += value
  end

  def reset_cards
    @hand.cards = []
  end

  def overload?
    @hand.count
  end

  def card_to_hand(card)
    @hand.take_card(card)
  end

  def cards_score
    @hand.score
  end
end
