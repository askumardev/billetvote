require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "redirects to login when no Clerk session is present" do
    get dashboard_path

    assert_redirected_to login_path
  end
end
