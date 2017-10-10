require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "mashrur", email: "mashrur@example.com",
                        password: "password", password_confirmation: "password",
                        lastname: "Hossain")
    @user2 = User.create!(username: "john", email: "john@example.com",
                        password: "password", password_confirmation: "password",
                        lastname: "Smith")
  end
  
  test "should get users listing" do
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user), text: @user.username.capitalize
    assert_select "a[href=?]", user_path(@user2), text: @user2.username.capitalize
  end

end
