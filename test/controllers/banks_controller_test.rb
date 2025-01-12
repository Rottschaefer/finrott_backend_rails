require "test_helper"

class BanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank = banks(:one)
  end

  test "should get index" do
    get banks_url, as: :json
    assert_response :success
  end

  test "should create bank" do
    assert_difference("Bank.count") do
      post banks_url, params: { bank: { institution_image_url: @bank.institution_image_url, institution_url: @bank.institution_url, name: @bank.name, primary_color: @bank.primary_color } }, as: :json
    end

    assert_response :created
  end

  test "should show bank" do
    get bank_url(@bank), as: :json
    assert_response :success
  end

  test "should update bank" do
    patch bank_url(@bank), params: { bank: { institution_image_url: @bank.institution_image_url, institution_url: @bank.institution_url, name: @bank.name, primary_color: @bank.primary_color } }, as: :json
    assert_response :success
  end

  test "should destroy bank" do
    assert_difference("Bank.count", -1) do
      delete bank_url(@bank), as: :json
    end

    assert_response :no_content
  end
end
