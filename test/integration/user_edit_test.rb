require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Index_Test", email: "Index_Text@example.com",
                      firstname: "First", lastname: "Last",
                      password: "password", password_confirmation: "password")
  end
  
  test "reject an invalid edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: " ", email: "test@example.com" } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept a valid edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "Index_Test1 ", email: "test@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "Index_Test1", @user.username
    assert_match "test@example.com", @user.email
  end

end
