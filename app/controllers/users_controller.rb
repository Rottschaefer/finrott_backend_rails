class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all


    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def create

    
    @user = User.new(user_params)

    token = encode_token(@user.email)

    if @user.save
      render json: {name: @user.name, email: @user.email, token: token}, status: :created, location: user_url(@user)
    else
      puts @user.errors
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
