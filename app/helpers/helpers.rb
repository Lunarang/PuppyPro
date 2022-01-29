require './config/environment'

class Helpers

  def self.current_user(session)
    User.find_by_id(session[:user_id])
  end

  def self.logged_in?(session)
    !!session[:user_id]
  end

  def self.belong_to_user?(session)
    Helpers.logged_in?(session) == true && session.id == Helpers.current_user(session).id
  end

end