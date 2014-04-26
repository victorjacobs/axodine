require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get index" do
    get :go
    assert_response :success
  end

end
