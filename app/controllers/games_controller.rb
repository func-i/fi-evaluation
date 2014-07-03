class GamesController < ApplicationController

  def bet
    @bet = params[:amount].to_i

    # => TODO  There might be a problem with the bet amount
    # => TODO: Correct any problems with it
    if (@bet > 0 && @bet > @player.balance)
      @invalid_bet = true
    else
      @secret = SecureRandom.hex(32)

      sha256 = Digest::SHA256.new
      sha256.update params[:bet_input]
      sha256.update @secret
      @result_hex = sha256.hexdigest.first(4)
      @result_int = @result_hex.to_i(16)
      @roll = SecureRandom.random_number(65535)

      if @result_int < @roll
        @player.update(balance: @player.balance + @bet)
        @message = "Winner!"
      else
        @message = "Loser!"
        @player.update(balance: @player.balance - @bet)
      end
    end

    render :show
  end
end
