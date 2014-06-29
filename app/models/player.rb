class Player < ActiveRecord::Base

  before_create :populate_uuid

  protected

  def populate_uuid
    self.uuid = SecureRandom.uuid
  end

end
