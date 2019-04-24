class Interface

START_LINE = "----------------> BLACK_JACK A♠ <----------------".freeze
GREET = "Добро пожаловать в игру Black Jack".freeze
LINE =       "-------------------------------------------------".freeze
ZLNE =       "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz".freeze
ACTIONS = [
    'Открыть карты',
    'Пропустить',
    'Добавить карту'
].freeze
BANK = 'Банк$ '.freeze
CARDS = 'Карты на руках '.freeze
ROUND_WINNER = "Победитель раунда: ".freeze
END_ROUND = "Раунд окончен ".freeze
PLAY_AGAIN = "Продолжим? |1 - да, 2 - нет| ".freeze
POINTS = "Очки: ".freeze
DEALER_PASS = "Dealer пропускает ход".freeze
DRAW = "Ничья".freeze
BILL = "На счету "
WINNER = "Победитель игры: "
NO_MONEY = "Деньги закончились!"

  def choice
    ACTIONS.each.with_index(1) { |action, index| puts "#{index}. #{action}" }
  end

  def view_info(player, dealer, bank)
    puts START_LINE
    puts BILL + "#{player.name}: #{player.cash}"
    puts BILL + "#{dealer.name}: #{dealer.cash}"
    puts LINE
    puts show_bank(bank)
    puts LINE
    puts CARDS + "#{player.name}"
    show_cards(player)
    puts ZLNE
    sleep(1)
    puts CARDS + "#{dealer.name}"
    hidden_cards(dealer)
    sleep(1)
  end

  def show_cards(player)
    player.hand.cards.each do |card|
      print "#{card.suit}"
      print ' '
      puts "#{card.value}"
    end
  end

  def cards_open_up(player, dealer)
    puts START_LINE
    puts CARDS + "#{player.name}"
    show_cards(player)
    puts POINTS + "#{player.hand.cards_score}"
    sleep(2)
    puts ZLNE
    puts CARDS + "#{dealer.name}"
    puts LINE
    show_cards(dealer)
    puts POINTS + "#{dealer.hand.cards_score}"
  end

  def show_cards(dealer)
    dealer.hand.cards.each do |card|
      print "#{card.suit}"
      print ' '
      puts "#{card.value}"
    end
  end

  def hidden_cards(dealer)
    dealer.hand.cards.each do
      puts '**'
    end
  end

  def show_winner(player)
    puts ROUND_WINNER + "#{player.name}"
  end

  def end_round(player, dealer)
    puts START_LINE
    puts LINE
    puts BILL + "#{player.name}: #{player.cash}"
    puts BILL + "#{dealer.name}: #{dealer.cash}"
  end

  def draw
    puts DRAW
  end

  def show_bank(bank)
    BANK + bank.bank.to_s
  end

  def dealer_pass
    puts DEALER_PASS
  end

  def play_again
    print PLAY_AGAIN
    gets.to_i
  end

  def enough_money
    puts NO_MONEY
  end
end
