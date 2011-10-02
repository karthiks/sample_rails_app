require 'spec_helper'

describe UsersController do
  render_views

  describe "#GET new" do
    it "should be successful" do
      get 'new'
      response.should be_success

      title = 'Sign up'
      assigns[:title].should == title
      response.should have_selector('title', :content => title)
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

  describe "#GET show" do
    before :each do
      @user = Factory(:user)
    end
    
    it "should be successful for a valid id" do
      get 'show', :id => @user
      response.should be_success
      response.should render_template 'show'
      
      title = 'User Details'
      assigns[:title].should == title      
      response.should have_selector('title', :content => title)      
    end

    it "should find the right user details" do
      get 'show', :id => @user
      assigns(:user).should == @user
    end
    
    it "should display the user name" do
      get 'show', :id => @user
      response.should have_selector('div', :content => @user.name)
    end

    it "should have a profile image" do
      get 'show', :id => @user
      response.should have_selector('img', :class => 'gravatar')
    end
  end

  describe "#POST create" do
    describe "#success" do
      before :each do
        @attributes = { :name => 'Peechumani', 
                        :email => 'peechu@money.com',
                        :password => "passwords!",
                        :password_confirmation => "passwords!" }    
      end
    
      it "should show confirmation page" do 
        
        lambda { post 'create', :user => @attributes }.should change(User,:count).by(1)

        response.should redirect_to(user_path(assigns[:user])) 
        flash[:notice].should =~ /Signup is successful/
      end
    end

    describe "#failure" do
      it "should return to sign-up page upon validation error" do
        post 'create', :user => {} 
        assigns[:user].errors.any?.should be_true
        assigns[:user].errors[:name].any?.should be_true
        assigns[:user].errors[:email].any?.should be_true
        assigns[:user].errors[:password].any?.should be_true
        response.should render_template('new')
      end
    end #describe "#failure"
  end #describe "#POST create"

end
