class PostitsController < ApplicationController
  before_action :set_postit, only: %i[ show update destroy ]
  before_action :authorized

  def index
    @postits = Postit.all

    render json: @postits
  end

  def show
    @postit = Postit.find(params[:id])
    render json: @postit
  end

  def create
    @postit = Postit.new(postit_params)
    @postit.user = current_user
    if @postit.save
      render json: @postit, status: :created, location: @postit
    else
      render json: @postit.errors, status: :unprocessable_entity
    end
  end

  def update
    if @postit.update(postit_params)
      render json: @postit
    else
      render json: @postit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @postit.destroy
  end

  private

    def set_postit
      @postit = Postit.find(params[:id])
    end

    def postit_params
      params.require(:postit).permit(:title, :body, :user_id)
    end
end
