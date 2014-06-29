class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_or_set_player

  protected

  def get_or_set_player

    # => Get the session UUID
    unless (uuid = session[:uuid]).blank?

      # => Find the player by uuid
      @player = Player.find_by(uuid: uuid)
    end

    # => If the player wasn't found, create one and set the session
    @player ||= Player.create
    session[:uuid] = @player.uuid
  end

end
