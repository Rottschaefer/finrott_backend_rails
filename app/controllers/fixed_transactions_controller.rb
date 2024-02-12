class FixedTransactionsController < ApplicationController
  before_action :set_fixed_transaction, only: %i[ show update destroy ]

  # GET /fixed_transactions
  def index
    @fixed_transactions = FixedTransaction.where(user_id: current_user[:id])

    render json: @fixed_transactions
  end

  # GET /fixed_transactions/1
  def show
    render json: @fixed_transaction
  end

  def get_fixed_transactions_amount
    month = params[:month].to_i
    year = params[:year].to_i
  
    fixed_transaction_amounts = FixedTransaction
    .where(user_id: current_user[:id])
    # .where("extract(year from updated_at) <= ? AND extract(month from updated_at) <= ?", year, month)
    .sum(:amount)

    render json: {total_amount: fixed_transaction_amounts}
  end


  # POST /fixed_transactions
  def create
    formattedParams = {
    description: fixed_transaction_params["description"],
    amount: fixed_transaction_params["amount"],
    category: fixed_transaction_params["category"],
    date: fixed_transaction_params["date"],
    user_id: current_user[:id],
  }
    @fixed_transaction = FixedTransaction.new(formattedParams)

    if @fixed_transaction.save
      render json: @fixed_transaction, status: :created, location: @fixed_transaction
    else
      render json: @fixed_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fixed_transactions/1
  def update
    if @fixed_transaction.update(fixed_transaction_params)
      render json: @fixed_transaction
    else
      render json: @fixed_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fixed_transactions/1
  def destroy
    @fixed_transaction.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixed_transaction
      @fixed_transaction = FixedTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fixed_transaction_params
      params.require(:fixed_transaction).permit(:user_id, :category, :description, :amount, :date)
    end
end
