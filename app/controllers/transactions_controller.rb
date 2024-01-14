class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]

  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  # 
  
  def create
    if transaction_params.length == 1
      # Processando uma única transação
      process_single_transaction(transaction_params.first)
    else
      # Processando múltiplas transações
      process_multiple_transactions(transaction_params)
    end
  end

     # PATCH/PUT /transactions/1
     def update
      if @transaction.update(transaction_params)
        render json: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /transactions/1
    def destroy
      @transaction.destroy!
    end

    def get_amount_per_category
      month = params[:month].to_i
      year = params[:year].to_i
    
      amountsPerCategory = Transaction
        .select("category_id, category, SUM(amount) as total_amount")
        .where(user_id: current_user[:id])
        .where("extract(year from date) = ? AND extract(month from date) = ?", year, month)
        .group("category_id, category")
        .order("total_amount DESC")
        .having("SUM(amount) > 0")
    
      render json: { amountsPerCategory: amountsPerCategory }
    end


    def get_transactions_per_category
      month = params[:month].to_i
      year = params[:year].to_i
      transactionsPerCategory = 
      Transaction
      .where(category_id: params[:category_id])
      .where(user_id: current_user[:id])
      .where("extract(year from date) = ? AND extract(month from date) = ?", year, month)

        
      render json: {transactionsPerCategory: transactionsPerCategory}
    end
    

  def first_setup_transactions
    
    accountId = params[:accountId]

    apiKey =  get_pluggy_key

    config = {"X-API-KEY" => apiKey}

    response = JSON.parse(HTTP.headers(config).get("https://api.pluggy.ai/transactions?accountId=#{accountId}").body)

    newData = formated_data(response["results"])


    if newData.length == 1
      process_single_transaction(newData.first)
    else
      process_multiple_transactions(newData)
    end
  end

  private

  def formated_data(transactions_data)

     
    formatted_transactions = transactions_data.map do |data|
      {
      pluggy_id: data["id"],
      description: data["description"],
      currency_code: data["currencyCode"],
      amount: data["amount"],
      date: data["date"],
      category: data["category"],
      category_id: data["categoryId"],
      account_pluggy_id: data["accountId"],
      status: data["status"],
      transaction_type: data["type"],
      merchant_business_name: data.dig("merchant", "businessName"),
      merchant_category: data.dig("merchant", "category"),
      user_id: current_user.id 
    }
    end
  end
  
  
  def process_single_transaction(params)

    formattedParams = {description: params["description"],
    amount: params["amount"],
    category: params["category"],
    user_id: 1,
  }
    transaction = Transaction.new(formattedParams)
    if transaction.save
      render json: transaction, status: :created, location: transaction
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end
  
  def process_multiple_transactions(params)
    transactions = params.map { |t| Transaction.new(t) }
    if transactions.all?(&:valid?)
      transactions.each(&:save)
      render json: transactions, status: :created # Ajuste a localização conforme necessário
    else
      render json: transactions.map(&:errors), status: :unprocessable_entity
    end
  end


  def for_month_and_year(year, month)
    Transaction.where("extract(year from date) = ? AND extract(month from date) = ?", year, month)
  end
  
      # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
     params[:transactions].map do |t|
      t.permit(:pluggy_id, :description, :currency_code, :amount, :date, :category, :category_id, :account_pluggy_id, :status, :transaction_type, :merchant_business_name, :merchant_category, :user_id)
     end
    end
end
