class BetService

  attr_accessor :invalid, :game, :amount

  def initialize(params, player)
    @amount = params[:amount].to_i
    @player = player
    @game = Game.new(params[:game_input])
  end

  def place
    if @amount <= 0 || @amount > @player.balance || !@game.valid?
      @invalid = true
    else
      @game.play(@player, @amount)
    end
  end

  def invalid?
    @invalid
  end

end