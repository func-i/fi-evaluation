class Game

  attr_reader :secret, :result_hex, :result_int, :max, :prize, :input, :message

  def self.all
    [
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

  def initialize(game_input)
    @game = Game.all.select{|g| g[:input].eql?(game_input)}.first

    if @game
      @max, @prize, @input = @game[:max], @game[:prize], @game[:input]
      generate_game_values
    end
  end

  def valid?
    @game
  end

  def play(player, bet)
    if @result_int < @max
      player.update(balance: player.balance + (@prize * bet))
      @message = "Winner!"
    else
      @message = "Loser!"
      player.update(balance: player.balance - bet)
    end
  end

  protected

  def generate_game_values
    @secret = SecureRandom.hex(32)

    sha256 = Digest::SHA256.new
    sha256.update @input
    sha256.update @secret

    @result_hex = sha256.hexdigest.first(4)
    @result_int = @result_hex.to_i(16)
  end

end