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
    if @user.id.nil?
      render(:action => 'new')
      return
    end
    flash[:notice] = "Signup is successful!"
    redirect_to user_path(@user)
  end
end
