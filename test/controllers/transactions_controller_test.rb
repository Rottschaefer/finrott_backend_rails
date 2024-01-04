require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url, as: :json
    assert_response :success
  end

  test "should create transaction" do
    assert_difference("Transaction.count") do
      post transactions_url, params: { transaction: { accountId: @transaction.accountId, amount: @transaction.amount, category: @transaction.category, categoryId: @transaction.categoryId, currencyCode: @transaction.currencyCode, date: @transaction.date, description: @transaction.description, merchant: @transaction.merchant, pluggy_id: @transaction.pluggy_id, status: @transaction.status, type: @transaction.type } }, as: :json
    end

    assert_response :created
  end

  test "should show transaction" do
    get transaction_url(@transaction), as: :json
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { accountId: @transaction.accountId, amount: @transaction.amount, category: @transaction.category, categoryId: @transaction.categoryId, currencyCode: @transaction.currencyCode, date: @transaction.date, description: @transaction.description, merchant: @transaction.merchant, pluggy_id: @transaction.pluggy_id, status: @transaction.status, type: @transaction.type } }, as: :json
    assert_response :success
  end

  test "should destroy transaction" do
    assert_difference("Transaction.count", -1) do
      delete transaction_url(@transaction), as: :json
    end

    assert_response :no_content
  end
end
