class Hand

  attr_accessor :cards

  MAX_CARDS = 3
  BLACK_JACK = 21
  ACE = 10

  def initialize
    @cards = []
  end

  def score
    total = @cards.sum(&:point)
    @cards.each do |card|
      total -= ACE if total > BLACK_JACK && card.ace?
    end
    total
  end

  def take_card(card)
    @cards << card  unless full?
  end

  def overload?
    score > BLACK_JACK
  end

  def full?
    @cards.size >= MAX_CARDS
  end
end
