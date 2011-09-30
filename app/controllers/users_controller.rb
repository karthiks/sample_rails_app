class UsersController < ApplicationController
  def new
    @title = 'Sign up'
    @user = User.new
  end

  def show
    @title = 'User Details'
    @user = User.find(params[:id])
  end
end
