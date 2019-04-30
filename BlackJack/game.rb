require_relative 'card.rb'
require_relative 'interface.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'bank.rb'
require_relative 'deck.rb'

class Game
  BET = 10

  attr_reader :player, :dealer, :name

  def start_game
    @interface = Interface.new
    create_player
    @hand = Hand.new
    @deck = Deck.new
    @dealer = Dealer.new("Dealer")
    @bank = Bank.new
    play_game
  end

  private

  def play_game
    loop do
      @bank.auto_bet(@player, @dealer)
      @deck.create_deck
      give_cards
      play_round
      end_round
      break unless players_have_money?
      exit unless repeat_round?
    end
    @interface.show_game_winner(winner_in_game)
  end

  def players_have_money?
    @bank.have_money?(@player) && @bank.have_money?(@dealer)
  end

  def create_player
    name = @interface.ask_name
    @player = Player.new(name)
  end

  def give_cards
    2.times do
      @player.card_to_hand(@deck.give_card)
      @dealer.card_to_hand(@deck.give_card)
    end
  end

  def play_round
    loop do
      @interface.view_info(@player, @dealer, @bank)
      case @interface.choice
      when 1 then return open_cards
      when 2 then dealer_turn
      when 3 then player_turn
      end
    end
  end

  def player_turn
    @player.card_to_hand(@deck.give_card) if @player.can_take_card?
    dealer_turn
  end

  def dealer_turn
    if @dealer.can_take_card?
      @dealer.card_to_hand(@deck.give_card)
    else
      @interface.pass
    end
  end

  def open_cards
    @interface.cards_open_up(@player, @dealer)
  end

  def drop_cards
    @player.reset_cards
    @dealer.reset_cards
  end

  def count_points(player, dealer)
    return if @player.overload? && @dealer.overload?
    return if @player.cards_score == @dealer.cards_score
    return @player if @player.cards_score > @dealer.cards_score || @dealer.overload?
    return @dealer if @player.cards_score < @dealer.cards_score || @player.overload?
  end

  def result
    case count_points(player, dealer)
    when @player
      @bank.winner(@player)
      @interface.show_winner(@player)
    when @dealer
      @bank.winner(@dealer)
      @interface.show_winner(@dealer)
    else
      @bank.draw(@player, @dealer)
      @interface.draw
    end
    drop_cards
  end

  def end_round
    result
    @interface.end_round(@player, @dealer)
  end

  def repeat_round?
    choice = @interface.play_again
    choice == 1
  end

  def winner_in_game
    if @player.cash > 0
      @player
    else
      @dealer
    end
  end
end
