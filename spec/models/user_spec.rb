require 'spec_helper'

describe User do

  describe "#validations" do
    before :each do 
      @user = User.create!(:name => 'Pichumani', :email => 'pichu@money.com')
    end

    it "should raise an error if name is not present" do
      @user.name = ""
      @user.save
      @user.errors.empty?.should == false
      @user.errors[:name].should == ["can't be blank"]
    end

    it "should raise an error when the name length exceeds 25 characters" do
      @user.name = "12345678901234567890123456"
      @user.save
      @user.errors.empty?.should == false
      @user.errors[:name].should == ["is too long (maximum is 25 characters)"]
    end

    it "should have an email-id" do 
      @user.email = ""
      @user.save
      @user.errors.empty?.should == false
      @user.errors[:email][0].should == "can't be blank"
    end

    it "should raise an error when the email is not in the prescribed format" do 
      @user.email = ".bing@@com"
      @user.save
      @user.errors.empty?.should == false
      @user.errors[:email].should == ["is invalid"]
    end

    it "should raise an error when the name-email combination is not unique" do 
      dup_user = User.new(:name => 'Pichumani', :email => 'pichu@money.com')
      dup_user.save
      dup_user.errors.empty?.should == false
      dup_user.errors[:name].should == ["has already been taken"]
    end
  end
end
