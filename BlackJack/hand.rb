class Hand

  attr_accessor :cards

  MAX_CARDS = 3
  BLACK_JACK = 21
  ACE = 10

  def initialize
    @cards = []
  end

  def cards_score
    sum ||= 0
    sum = @cards.sum(& :point)
    @cards.each do |card|
      if sum  > BLACK_JACK && card.ace?
      end
    end
    sum
  end

  def take_card(card)
    @cards << card  if can_take?
  end

  def can_take?
    @cards.size < Hand::MAX_CARDS
  end
end
