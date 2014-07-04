class GamesController < ApplicationController

  def show
    load_games
  end

  def bet
    load_games

    @bet = params[:amount].to_i

    @game = @games.select{|g| g[:input].eql?(params[:game_input])}.first

    # => TODO  There might be a problem with the bet amount
    # => TODO: Correct any problems with it
    if (@bet > 0 && @bet > @player.balance) || !@game
      @invalid_bet = true
    else
      @secret = SecureRandom.hex(32)

      sha256 = Digest::SHA256.new
      sha256.update @game[:input]
      sha256.update @secret
      @result_hex = sha256.hexdigest.first(4)
      @result_int = @result_hex.to_i(16)

      if @result_int < @game[:max]
        @player.update(balance: @player.balance + (@game[:prize] * @bet))
        @message = "Winner!"
      else
        @message = "Loser!"
        @player.update(balance: @player.balance - @bet)
      end
    end

    render :show
  end

  def load_games
    @games = [
      {
        max: 65535,
        prize: 1.0044,
        input: "ac5b71b8d917e7e9835c4b1248d186f4e5672ea539adf8a899f996b64a908add"
      },
      {
        max: 48000,
        prize: 1.3376,
        input: "71b958df5db6a35ecee1b63b90a345667966b930cc8d663d560878e040d4a69c"
      },
      {
        max: 32000,
        prize: 2.0038,
        input: "2cc0b891f18a8881a3ef0f91ce5015cc4e73dbd3b5685606a0af0e411242269d"
      },
      {
        max: 16000,
        prize: 4.0027,
        input: "fc9a0d41512fe185694cb34b4eb0a888842b69d85db0ee15ba5829461971907a"
      },
      {
        max: 4000,
        prize: 15.9958,
        input: "b0a99f01ac0b4d5b82335863d466fbb1b14df8f8b450f9a2770d52d1b453b437"
      }
    ]
  end

end