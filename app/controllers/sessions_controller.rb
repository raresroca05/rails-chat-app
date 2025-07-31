class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      redirect_to root_path, notice: "Welcome back, #{@user.display_name}!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path, notice: "You have been signed out"
  end
end
