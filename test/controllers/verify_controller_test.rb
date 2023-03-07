require "test_helper"

class VerifyControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get verify_generate_url
    assert_response :success
  end

  test "should get authenticate" do
    get verify_authenticate_url
    assert_response :success
  end
end
