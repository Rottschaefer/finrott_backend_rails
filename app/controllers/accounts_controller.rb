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

    pluggyApiKey = get_pluggy_key()
    config = {"X-API-KEY" => pluggyApiKey}


    urlToGetItems = "https://api.pluggy.ai/items/#{account_params["item_id"]}"

    itemsResponse = JSON.parse(HTTP.headers(config).get(urlToGetItems).body)


    urlToGetAccount = "https://api.pluggy.ai/accounts?itemId=#{account_params["item_id"]}"

    accountsResponse = JSON.parse(HTTP.headers(config).get(urlToGetAccount).body)["results"]


    urlToGetAccountInfo = "https://api.pluggy.ai/accounts/#{accountsResponse[0]["id"]}"

    accountInfo = JSON.parse(HTTP.headers(config).get(urlToGetAccountInfo).body)

    accountToSave = {
      pluggy_id: accountInfo["id"],
      item_id: accountInfo["itemId"],
      user_id: current_user.id,
      balance: accountInfo["balance"],
      bank_name: itemsResponse["connector"]["name"],
      bank_primary_color: itemsResponse["connector"]["primaryColor"],
      institution_url: itemsResponse["connector"]["institutionUrl"],
      institution_image_url: itemsResponse["connector"]["imageUrl"],

    }

    puts accountToSave


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
      params.require(:account).permit(:pluggy_id, :item_id, :user_id, :bank_name, :balance, :bank_primary_color, :institution_url, :institution_image_url)
    end
end
