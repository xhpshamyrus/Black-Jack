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
  ASK_NAME = "Укажите Ваше имя?"
  END_ROUND = "Раунд окончен ".freeze
  PLAY_AGAIN = "Продолжим? |1 - да, 2 - нет| ".freeze
  PLAY_GAME_AGAIN = "Начать игру заново? |1 - да, 2 - нет| ".freeze
  POINTS = "Очки: ".freeze
  PASS = "пропускает ход".freeze
  DRAW = "Ничья".freeze
  BILL = "На счету "
  WINNER = "Победитель игры: "
  NO_MONEY = "Деньги закончились!"

  def choice
    ACTIONS.each.with_index(1) { |action, index| puts "#{index}. #{action}" }
    gets.to_i
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
    puts CARDS + "#{dealer.name}"
    hidden_cards(dealer)
  end

  def ask_name
    puts ASK_NAME
    name = gets.chomp.capitalize
    name = name.empty? ? 'Player' : name
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
    puts POINTS + "#{player.cards_score}"
    puts ZLNE
    puts CARDS + "#{dealer.name}"
    puts LINE
    show_cards(dealer)
    puts POINTS + "#{dealer.cards_score}"
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

  def pass
    puts PASS
  end

  def play_again
    print PLAY_AGAIN
    gets.to_i
  end

  def play_game_again
    print PLAY_GAME_AGAIN
    gets.to_i
  end

  def enough_money
    puts NO_MONEY
  end

  def show_game_winner(player)
    puts WINNER + "#{player.name}"
  end
end
