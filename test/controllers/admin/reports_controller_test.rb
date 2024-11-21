require "test_helper"

class Admin::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reports_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_reports_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_reports_destroy_url
    assert_response :success
  end
end
