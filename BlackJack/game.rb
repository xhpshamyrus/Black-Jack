require_relative 'card.rb'
require_relative 'interface.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'bank.rb'

class Game
  BET = 10

  attr_reader :player, :dealer

  def start_game
    @interface = Interface.new
    create_player
    @dealer = Dealer.new("Dealer")
    @bank = Bank.new
    new_round
  end

  def create_player
    puts "Укажите Ваше имя?"
    name = gets.chomp.capitalize
    @player = Player.new(name)
  end

  def new_round
    @bank.auto_bet(@player, @dealer)
    create_deck
    give_cards
    player_move
    end_round
  end

  def create_deck
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value, point|
        @cards << Card.new(suit, value, point)
      end
    end
     @cards.shuffle!
  end

  def give_card
    @cards.shift
  end

  def give_cards
    2.times do
      @player.hand.take_card(give_card)
      @dealer.hand.take_card(give_card)
    end
  end

  def player_move
    loop do
      @interface.view_info(@player, @dealer, @bank)
      @interface.choice
      chosen = gets.to_i
      case chosen
      when 1 then return open_cards
      when 2 then
        dealer_move
      when 3 then
        @player.hand.take_card(give_card)
        dealer_move
      end
    end
  end

  def dealer_move
    if @dealer.hand.cards_score < 17
       @dealer.hand.take_card(give_card)
    else
      @interface.dealer_pass
    end
  end

  def open_cards
    @interface.cards_open_up(@player, @dealer)
    winner = winner_in_round(@player, @dealer)
  end

  def drop_cards
    @player.reset_cards
    @dealer.reset_cards
  end

  def winner_in_round(player, dealer)
    player_points = @player.hand.cards_score
    dealer_points = @dealer.hand.cards_score
    return @player if dealer_points > Hand::BLACK_JACK
    return @dealer if player_points > Hand::BLACK_JACK
    return @interface.draw if dealer_points == player_points
    return @dealer if dealer_points == Hand::BLACK_JACK
    return @player if player_points == Hand::BLACK_JACK

    if player_points < Hand::BLACK_JACK && dealer_points < Hand::BLACK_JACK
      player_points > dealer_points ? @player : @dealer
    else
      player_points < dealer_points ? @dealer : @player
    end
  end

  def result
    case winner_in_round(@player, @dealer)
      when @player
        @bank.winner(@player)
        @interface.show_winner(@player)
      when @dealer
        @bank.winner(@dealer)
        @interface.show_winner(@dealer)
    else
      @bank.draw(@player, @dealer)
    end
    drop_cards
  end

  def end_round
    result
    @interface.end_round(@player, @dealer)
    repeat_round
  end

  def repeat_round
    if @bank.have_money?(@player) && @bank.have_money?(@dealer)
      choice = @interface.play_again
      case choice
        when 1 then new_round
        when 2 then exit
      end
    else
      @interface.enough_money
    end
  end

  def winner_in_game
    if @player.cash > 0
      @player
    else
      @dealer
    end
  end
end
