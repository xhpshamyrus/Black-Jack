class Card
  attr_reader :suit, :value, :point

  SUITS = %w[♠ ♥ ♣ ♦]
  VALUES = {
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "J" => 10,
      "Q" => 10,
      "K" => 10,
      "A" => 11
    }

  def initialize(suit, value, point)
    @suit = suit
    @value = value
    @point = point
  end

  def ace?
    @value == 'A'
  end
end
