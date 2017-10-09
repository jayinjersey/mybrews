require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Index_Test", email: "Index_Text@example.com",
                      firstname: "First", lastname: "Last",
                      password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Index Test Recipe One", description: "Index Test Recipe Description One", user: @user)
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
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_select "a[href=?]", recipe_path(@recipe3), text: @recipe3.name
  end
  
 test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name.titleize, response.body
    assert_match @recipe.description, response.body
    assert_match @user.username, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
    assert_select 'a[href=?]', recipes_path, text: "Return to recipes listing"
  end
  
  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "Test Recipe"
    description_of_recipe = "New Recipe Test Description Steps"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_recipe} }
    end
    follow_redirect!
    assert_match name_of_recipe.titleize, response.body
    assert_match description_of_recipe, response.body
  end
  
  test "reject invalid recipe" do
    get new_recipe_path  
    assert_template 'recipes/new'
    assert_no_difference'Recipe.count' do
      post recipes_path, params: { recipe: {name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
