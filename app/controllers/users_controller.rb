class UsersController < ApplicationController
  def new
    @title = 'Sign up'
    @user ||= User.new
  end

  def show
    @title = 'User Details'
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params['user'])
    @user.save
    @title = 'Sign-up confirmation'
    unless(@user.id)
      render :action => 'new'
    end
  end
end
