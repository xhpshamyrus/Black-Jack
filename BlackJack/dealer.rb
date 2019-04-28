class Dealer < Player
  MAX_POINTS = 17

  def can_take_card?
    if cards_score < MAX_POINTS && @hand.full?
      super
    end
  end
end
