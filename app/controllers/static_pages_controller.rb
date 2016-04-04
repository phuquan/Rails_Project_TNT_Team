class StaticPagesController < ApplicationController
  def home
  	@images = Image.all()
  end
end
