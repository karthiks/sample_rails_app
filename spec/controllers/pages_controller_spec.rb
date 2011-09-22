require 'spec_helper'

describe PagesController do
  render_views
  
  describe "GET Home" do
    it "should land to Home page" do
      get 'home'
      response.should render_template("pages/home")
      response.should have_selector('title', :content => 'Home')
    end
  end

  describe "GET About" do
    it "should land to About page" do
      get 'about'
      response.should render_template("pages/about")
      response.should have_selector('title', :content => 'About')
    end
  end

  describe "GET Contact" do
    it "should land to Contact page" do
      get 'contact'
      response.should render_template("pages/contact")
      response.should have_selector('title', :content => 'Contact')
    end
  end

  describe "GET Help" do
    it "should land to Help page" do
      get 'help'
      response.should render_template("pages/help")
      response.should have_selector('title', :content => 'Help')
    end
  end

end
