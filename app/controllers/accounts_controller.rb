require "http"

class AccountsController < ApplicationController

  # skip_before_action :authorized, only: [:create]
  before_action :set_account, only: [ :show, :update, :destroy ]

  # GET /accounts
  def index
    @accounts = Account.left_outer_joins(:bank).select('accounts.*, banks.*').where("user_id=?", current_user[:id])

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create

    accountToSave = {
      user_id: current_user.id,
      balance: account_params["balance"],
      bank_name: account_params["bank_name"],
    }



    @account = Account.new(accountToSave)


    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:bank_name, :balance)
    end
end
