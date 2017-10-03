require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Index_Test", email: "Index_Text@example.com")
    @recipe1 = Recipe.create(name: "Index Test Recipe One", description: "Index Test Recipe Description One", user: @user)
    @recipe2 = Recipe.create(name: "Index Text Recipe Two", description: "Index Test Recipe Description Two", user: @user)
    @recipe3 = Recipe.create(name: "Index Text Recipe Three", description: "Index Test Recipe Description Three", user: @user)
  end
  
  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe1.name, response.body
    assert_match @recipe2.name, response.body
    assert_match @recipe3.name, response.body
  end
end
