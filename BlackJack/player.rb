require_relative 'hand.rb'

class Player

  CASH = 100

  attr_accessor :name, :cash, :cards, :hand

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
end
