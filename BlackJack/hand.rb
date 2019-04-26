class Hand

  attr_accessor :cards

  MAX_CARDS = 3
  BLACK_JACK = 21
  ACE = 10
  MAX_POINTS = 17

  def initialize
    @cards = []
  end

  def score
    total ||= 0
    total = @cards.sum(& :point)
    @cards.each do |card|
      if total  > BLACK_JACK && card.ace?
      end
    end
    total
  end

  def take_card(card)
    @cards << card  if can_take?
  end

  def count
    score > BLACK_JACK
  end

  def can_take?
    @cards.size < MAX_CARDS
  end
end
