class PlayersController < ApplicationController

  def new
    @player = Player.new
  end

  def create
  	@player = Player.new(post_params)
    @player.avatarurl = session[:current_user].fetch('image')
    @player.nickname = session[:current_user].fetch('nickname')
    @player.steamid = session[:current_user].fetch('uid')
    @player.steamprofile_url = session[:current_user].fetch('profile')

    if Player.where(:steamid => session[:current_user].fetch('uid')).blank?
      @player.save
    else
      @player = Player.find_by(:steamid => session[:current_user].fetch('uid'))
      @player.avatarurl = session[:current_user].fetch('image')
      @player.nickname = session[:current_user].fetch('nickname')
      @player.update(post_params)
    end

  	redirect_to :back
  end

  private
  	def post_params
  		params.require(:player).permit(:avatarurl, :nickname, :steamid, :region, :steamprofile_url, :vampire, :human, :comment)
  	end

end
