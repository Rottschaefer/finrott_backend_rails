require "http"

class AccountsController < ApplicationController

  # skip_before_action :authorized, only: [:create]
  before_action :set_account, only: [ :show, :update, :destroy ]

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create

    pluggyApiKey = get_pluggy_key
    config = {"X-API-KEY" => pluggyApiKey}

    urlToGetAccount = "https://api.pluggy.ai/accounts?itemId=#{account_params["item_id"]}"

    accountsResponse = JSON.parse(HTTP.headers(config).get(urlToGetAccount).body)["results"]


    urlToGetAccountInfo = "https://api.pluggy.ai/accounts/#{accountsResponse[0]["id"]}"

    accountInfo = JSON.parse(HTTP.headers(config).get(urlToGetAccountInfo).body)


    accountToSave = {
      pluggy_id: accountInfo["id"],
      item_id: accountInfo["itemId"],
      user_id: current_user.id
    }

    render json: {response: accountsResponse}

    # @account = Account.new(accountToSave)


    # if @account.save
    #   render json: @account, status: :created, location: @account
    # else
    #   render json: @account.errors, status: :unprocessable_entity
    # end

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
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:pluggy_id, :item_id, :user_id, :transfer_number, :bank_name, :name, :balance)
    end
end
