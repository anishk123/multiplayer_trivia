require "test_helper"

class QaControllerTest < ActionDispatch::IntegrationTest
  test "should get random" do
    get qa_random_url
    assert_response :success
  end
end
