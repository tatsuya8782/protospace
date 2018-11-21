class PrototypesController < ApplicationController
  before_action :set_prototype, only: :show

  def index
    @prototypes = Prototype.page(params[:page]).per(8).order('updated_at DESC')
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: '登録出来ました'
    else
      redirect_to ({ action: 'new' }), alert: '登録できません'
     end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    @new_comment = @prototype.comments.build
  end

  def destroy
      prototype = Prototype.find(params[:id])
      prototype.destroy if prototype.user_id == current_user.id
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
      prototype = Prototype.find(params[:id])
      prototype.update(update_prototype_params) if prototype.user_id == current_user.id
      redirect_to prototype_path, notice: '編集しました'
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status]
    )
  end

  def update_prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :id]
    )
  end

end
