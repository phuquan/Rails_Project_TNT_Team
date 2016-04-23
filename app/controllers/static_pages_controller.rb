class StaticPagesController < ApplicationController
  def home
  	if (params[:search])
      @images = Image.where("name LIKE ? and user_id = ?", "%#{params[:search]}%", "#{current_user.id}")
    else
      @images = Image.all()
    end
  end
end
