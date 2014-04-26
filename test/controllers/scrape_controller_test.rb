require 'test_helper'

class ScrapeControllerTest < ActionController::TestCase
  test "should get index" do
    get :go
    assert_response :success
  end

end
