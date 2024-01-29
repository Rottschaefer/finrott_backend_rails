require "test_helper"

class FixedTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fixed_transaction = fixed_transactions(:one)
  end

  test "should get index" do
    get fixed_transactions_url, as: :json
    assert_response :success
  end

  test "should create fixed_transaction" do
    assert_difference("FixedTransaction.count") do
      post fixed_transactions_url, params: { fixed_transaction: { amount: @fixed_transaction.amount, category: @fixed_transaction.category, description: @fixed_transaction.description, user_id: @fixed_transaction.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show fixed_transaction" do
    get fixed_transaction_url(@fixed_transaction), as: :json
    assert_response :success
  end

  test "should update fixed_transaction" do
    patch fixed_transaction_url(@fixed_transaction), params: { fixed_transaction: { amount: @fixed_transaction.amount, category: @fixed_transaction.category, description: @fixed_transaction.description, user_id: @fixed_transaction.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy fixed_transaction" do
    assert_difference("FixedTransaction.count", -1) do
      delete fixed_transaction_url(@fixed_transaction), as: :json
    end

    assert_response :no_content
  end
end
