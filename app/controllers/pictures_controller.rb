class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    Picture.create(picture_params)
    if @picture.save
      redirect_to pictures_path, notice: "ブログを作成しました"
    else
      render :new
    end
  end

  def show
    @picture =Picture.find(params[:id])
  end

  private

  def picture_params
    params.require(:picture).permit(:content)
  end
end
