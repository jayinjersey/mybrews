require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Index_Test", email: "Index_Text@example.com",
                      firstname: "First", lastname: "Last",
                      password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Index Test Recipe One", description: "Index Test Recipe Description One", user: @user)
    @recipe2 = Recipe.create(name: "Index Text Recipe Two", description: "Index Test Recipe Description Two", user: @user)
    @recipe3 = Recipe.create(name: "Index Text Recipe Three", description: "Index Test Recipe Description Three", user: @user)
  end
  
  test "should get users show" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_select "a[href=?]", recipe_path(@recipe3), text: @recipe3.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @recipe3.description, response.body
    assert_match @user.username, response.body
  end



end
