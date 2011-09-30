require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
      response.should have_selector('title', :content => 'Sign up')
    end

    it "should have form with all required fields" do
      get 'new'
      response.should have_selector('form#new_user')
      response.should have_selector('form div input#user_name')
      response.should have_selector('form div input#user_email')
      response.should have_selector('form div input#user_password')
      response.should have_selector('form div input#user_password_confirmation')
      response.should have_selector('form div input#user_submit')
    end
  end

  describe "GET show" do
    before :each do
      @user = Factory(:user)
    end
    
    it "should be successful for a valid id" do
      get 'show', :id => @user
      response.should be_success
      response.should have_selector('title', :content => 'User Details')      
    end

    it "should find the right user details" do
      get 'show', :id => @user
      assigns(:user).should == @user
    end
    
    it "should display the user name" do
      get 'show', :id => @user
      response.should have_selector('h1', :content => @user.name)
    end

    it "should have a profile image" do
      get 'show', :id => @user
      response.should have_selector('img', :class => 'gravatar')
    end
  end

end
