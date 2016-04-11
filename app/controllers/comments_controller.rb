class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @image = Image.find(@comment.image_id)
    respond_to do |format|
      if @comment.save
        @new_comment = Comment.new
        format.html  { redirect_to(:back, :notice => 'Comment was successfully added.') }
        format.js
      else
        format.html  { render :action => "new" }
      end
    end
  end

  def destroy
  end
  
  private
  def comment_params
      params.require(:comment).permit(:context, :image_id, :user_id)
  end
end
