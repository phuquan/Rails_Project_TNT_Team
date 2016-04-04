class StaticPagesController < ApplicationController
	
  before_action :authenticate_user!

  def home
  	@images = current_user.images
  end
end
