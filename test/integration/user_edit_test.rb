require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Index_Test", email: "Index_Text@example.com",
                      firstname: "First", lastname: "Last",
                      password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "john", email: "john@example.com",
                      password: "password", password_confirmation: "password",
                      lastname: "Smith")
    @admin_user = User.create!(username: "admin_user", email: "admin_user@example.com",
                      password: "password", password_confirmation: "password",
                      lastname: "Smith", admin: true)
  end
  
  test "reject an invalid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: " ", email: "test@example.com" } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept a valid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "Index_Test1 ", email: "test@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "Index_Test1", @user.username
    assert_match "test@example.com", @user.email
  end
  
  test " accept edit attempt by admin" do
    sign_in_as(@admin_user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "Index_Test3", email: "test3@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "Index_Test3", @user.username
    assert_match "test3@example.com", @user.email
  end
  
  test "redirect edit attempt by another non-admin" do
    sign_in_as(@user2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch user_path(@user), params: { user: { username: updated_name, email: updated_email } }
    assert_redirected_to users_path
    assert_not flash.empty?
    @user.reload
    assert_match "Index_Test", @user.username
    assert_match "index_text@example.com", @user.email
  end

end
