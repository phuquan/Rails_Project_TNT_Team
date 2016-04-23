class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :new, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:index, :create, :update]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
    @height = (@images.size / 3) * 303
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @tags = ImageTag.joins(:tag).where(image_id: @image.id)
    @comments = @image.comments
    @new_comment = @image.comments.build
    tag_ids = Array.new
    for tag in @tags
      tag_ids << tag.tag_id
    end
    @relative_images = ImageTag.joins(:image).where(:tag_id => tag_ids).where.not(image_id: @image.id)
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
    @tags = ImageTag.joins(:tag).select(:name).where(image_id: @image.id)
    if @tags != nil
      tags = "";
      for tag in @tags
        tags += tag.name + ",";
      end
      tags = tags[0...-1]
      @tags = tags
    end
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.user_id  = current_user.id
    respond_to do |format|
      if @image.save
        delete_all_tag(@image.id)
        tags = params[:image][:tag]
        tags = tags.split(',')
        tags = tags.uniq
        tags.each do |tag|
          @tag = Tag.find_by(name: tag)
          if @tag == nil
            @tag = Tag.new
            @tag.name = tag
            @tag.save
          end
          @image_tag = ImageTag.new
          @image_tag.image_id = @image.id
          @image_tag.tag_id = @tag.id
          @image_tag.save
        end
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :index }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        delete_all_tag(@image.id)
        tags = params[:image][:tag]
        tags = tags.split(',')
        tags = tags.uniq
        tags.each do |tag|
          @tag = Tag.find_by(name: tag)
          if @tag == nil
            @tag = Tag.new
            @tag.name = tag
            @tag.save
          end
          @image_tag = ImageTag.new
          @image_tag.image_id = @image.id
          @image_tag.tag_id = @tag.id
          @image_tag.save
        end
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :description, :url, :is_shared)
    end
    
    def delete_all_tag (image_id)
      ImageTag.where(image_id: image_id).delete_all
    end
end
