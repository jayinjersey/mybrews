require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "test_user", email: "test_user@example.com",
                    firstname: "First", lastname: "Last",
                    password: "password", password_confirmation: "password")
  end
  
  test "user should be valid" do
    assert @user.valid?
  end
  
  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end
  
  test "username should be less than 30 characters" do
    @user.username = "a" * 31
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "email should not be longer than 255 characters" do
    @user.email = "a" * 245 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email should accept correct format" do
    valid_emails = %w[user@example.com user@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @user.email = valids
      assert @user.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid email format" do
    invalid_emails = %w[user@example user@example,com user.name@gmail. user@example+example.com]
    invalid_emails.each do |invalids|
      @user.email = invalids
      assert_not @user.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case insensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email should be lower case before hitting db" do
    mixed_email = "jOhN@Example.com"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end
  
  test "password should be atleast 5 characters" do
    @user.password = @user.password_confirmation = "x" * 4
    assert_not @user.valid? 
  end
  
end