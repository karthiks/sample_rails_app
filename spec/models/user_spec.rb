require 'spec_helper'

describe User do

  before :each do 
    @attr = { :name => 'Pichumani', 
              :email => 'pichu@money.com',
              :password => "password!",
              :password_confirmation => "password!" }
  end

  describe "#validations" do
    it "should create a new instance when the attributes are valid" do 
      user = User.new(@attr)
      user.save
      user.errors.empty?.should == true
      user.id.should_not be_nil
    end

    it "should raise an error if name is not present" do
      user = User.new(@attr)
      user.name = ""
      user.save
      user.errors.empty?.should == false
      user.errors[:name].include?("can't be blank").should == true
    end

    it "should raise an error when the name length exceeds 25 characters" do
      user = User.new(@attr)
      user.name = "12345678901234567890123456"
      user.save
      user.errors.empty?.should == false
      user.errors[:name].include?("is too long (maximum is 25 characters)").should == true
    end

    it "should have an email-id" do 
      user = User.new(@attr)
      user.email = ""
      user.save
      user.errors.empty?.should == false
      user.errors[:email].include?("can't be blank").should == true
    end

    it "should raise an error when the email is not in the prescribed format" do 
      user = User.new(@attr)
      user.email = ".bing@@com"
      user.save
      user.errors.empty?.should == false
      user.errors[:email].include?("is invalid").should == true
    end

    it "should raise an error when the name-email combination is not unique" do 
      user = User.new(@attr)
      user.save!
      dup_user = User.new(:name => 'Pichumani', :email => 'pichu@money.com', :password => "123", :password_confirmation => "123")
      dup_user.save
      dup_user.errors.empty?.should == false
      dup_user.errors[:name].include?("has already been taken").should == true
    end

    it "should raise an error when password is not present" do 
      user = User.new(@attr.merge(:password => ""))
      user.save
      user.errors.empty?.should == false
      user.errors[:password].include?("can't be blank").should == true 
    end
    
    it "should raise an error when password confirmation is not present" do 
      user = User.new(@attr.merge(:password_confirmation => "invalid passcode"))
      user.save
      user.errors.empty?.should == false
      user.errors[:password].include?("doesn't match confirmation").should == true
    end

    it "should raise an error when password length is less than 6 characters" do 
      user = User.new(@attr.merge(:password => "12345", :password_confirmation => "12345"))
      user.save
      user.errors.empty?.should == false
      user.errors[:password].include?("is too short (minimum is 6 characters)").should == true
    end
    
    it "should raise an error awhen password length is greater than 20 characters" do
      user = User.new(@attr.merge(:password => "123456789012345678901", :password_confirmation => "123456789012345678901"))
      user.save
      user.errors.empty?.should == false
      user.errors[:password].include?("is too long (maximum is 20 characters)").should == true
    end
  end

  it "should save encrypted password in database" do 
    user = User.new(@attr)
    user.encrypted_password.should be_nil
    user.save
    user.encrypted_password.should_not be_nil
    user.encrypted_password.should_not == user.password
  end

  it "should store his security salt in database" do 
    user = User.new(@attr)
    user.salt.should be_nil
    user.save
    user.salt.should_not be_nil
  end

  describe "#has_password? method" do
    it "should return true if the user submitted password matches the one in database" do 
      user = User.new(@attr)
      user.save
      user.has_password?(@attr[:password]).should be_true
    end
    
    it "should return false if the user submitted password does not match the one in database" do 
      user = User.new(@attr)
      user.save
      user.has_password?("invalid_password").should be_false
    end
  end

  describe "#authenticate method" do
    before :all do 
      @attr = { :name => 'Pichumani', 
              :email => 'pichu@money.com',
              :password => "password!",
              :password_confirmation => "password!" }
      User.new(@attr).save!
    end
    
    it "should exist" do
      User.should respond_to(:authenticate)
    end

    it "should return nil on invalid password submission" do
      User.authenticate(@attr[:email],"wrong_password").should be_nil
    end

    it "should return nil on non-existant email record" do
      User.authenticate("wrong@mail.net","random_password").should be_nil
    end

    it "should return the user on correct email/password submission" do
      user = User.authenticate(@attr[:email],@attr[:password])
      user.name.should == @attr[:name]
    end
  end
end
