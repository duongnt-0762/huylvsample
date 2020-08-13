class UsersController < ApplicationController
	before_action :check_logged_in, only: [:new]
	def show
		@user = User.find_by(id:params[:id])
		if @user.nil?
			flash[:danger] = "User khong ton tai!!!"
			redirect_to root_path
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render :new
		end
	end

	private

	def check_logged_in
		if logged_in?
			flash[:danger] = "You are logging..."
			redirect_to root_path
		end	
	end

	def user_params
		params.require(:user).permit(:name, :email, :password,
									 :password_confirmation,
									 :date_of_birth,
									 :que_quan,
									 :gioi_tinh,
									)
	end


end
