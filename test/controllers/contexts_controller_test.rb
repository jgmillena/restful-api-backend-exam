require "test_helper"

class ContextsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @context = contexts(:one)
  end

  test "should get index" do
    get contexts_url, as: :json
    assert_response :success
  end

  test "should create context" do
    assert_difference("Context.count") do
      post contexts_url, params: { context: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show context" do
    get context_url(@context), as: :json
    assert_response :success
  end

  test "should update context" do
    patch context_url(@context), params: { context: {  } }, as: :json
    assert_response :success
  end

  test "should destroy context" do
    assert_difference("Context.count", -1) do
      delete context_url(@context), as: :json
    end

    assert_response :no_content
  end
end
