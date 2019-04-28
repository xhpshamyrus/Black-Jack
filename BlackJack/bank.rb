class Bank
  BET = 10

  attr_reader :bank

  def initialize
    @bank = 0
  end

  def auto_bet(player, dealer)
    player.make_bet(BET)
    dealer.make_bet(BET)
    @bank = BET * 2
  end

  def winner(player)
    player.add_cash(@bank)
    @bank = 0
  end

  def draw(player, dealer)
    player.add_cash(@bank / 2)
    dealer.add_cash(@bank / 2)
    @bank = 0
  end

  def have_money?(player)
    player.cash > BET
  end
end
