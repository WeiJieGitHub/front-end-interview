require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get modal" do
    get static_pages_modal_url
    assert_response :success
  end

end
