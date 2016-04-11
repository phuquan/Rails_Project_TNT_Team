class CommentController < ApplicationController
 
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    
    respond_to do |format|
      if @comment.save
        # format.html { redirect_to @comment.image, notice: 'Comment was successfully created.' }
        format.js   { }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def comment_params
      params.require(:comment).permit(:user_id, :image_id, :context)
  end
end