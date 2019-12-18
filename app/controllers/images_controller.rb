class ImagesController < ApplicationController
  def index
    @tag = params[:tag]
    @images = @tag ? Image.tagged_with([@tag]).order('created_at DESC') : Image.all.order('created_at DESC')
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image
    else
      render 'new'
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:title, :link, :tag_list)
  end
end
