class Dealer < Player
  MAX_POINTS = 17

  def can_take_card?
    super && cards_score < MAX_POINTS
  end
end
