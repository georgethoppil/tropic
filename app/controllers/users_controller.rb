require "#{Rails.root}/lib/email_service"

class UsersController < ApplicationController
  def index
    @users = User.all 
    end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      if params[:send_invitation] == '1' && EmailService.send_email(@user.email)
          @user.save
          flash[:notice] = "Success! \n User created"
      else
        flash[:alert] = "User not created!"
      end
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.required(:user).permit(:first_name, :last_name, :email)
  end
end
