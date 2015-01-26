class WelcomeController < ApplicationController
  # auth callback POST comes from Steam so we can't attach CSRF token
  skip_before_filter :verify_authenticity_token, :only => :auth_callback

  def index
    @gamelist = []
    if session.key? :current_user
      url = URI.parse("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_WEB_API_KEY']}&steamid=#{session[:current_user].fetch('uid')}")
      res = Net::HTTP::get(url)
      gamelist = JSON.load(res)['response']['games'] || []
      @Nosgoth = gamelist.find {|game| game["appid"] == 200110}
    end
    @players = Player.all
  end

  def auth_callback
    auth = request.env['omniauth.auth']
    session[:current_user] = { :nickname => auth.info['nickname'],
                               :image => auth.info['image'],
                               :uid => auth.uid,
                               :profile => auth.info.urls['Profile'] }
    redirect_to root_url
  end

  def session_logout
    session.clear
    redirect_to root_url
  end

end
