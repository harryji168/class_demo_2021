class UsersController < ApplicationController
    def show
        @user = User.find params[:id]
    end

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: 'Logged in'
        else
            render :new
        end
    end
    

    private

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :address
        )
    end
    
end
