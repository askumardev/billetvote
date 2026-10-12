require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "shows email and password fields for Clerk sign-in" do
    get login_url

    assert_response :success
    assert_select "form#login-form" do
      assert_select "input#login-email[type=email][name=email]"
      assert_select "input#login-password[type=password][name=password]"
      assert_select "button#login-submit:not([disabled])"
    end
    assert_select "form#verification-form[hidden]"
    assert_select "button#verification-submit:not([disabled])"
    assert_select "script", text: /client\.signIn\.create/
    assert_select "script", text: /prepareSecondFactor/
  end
end
