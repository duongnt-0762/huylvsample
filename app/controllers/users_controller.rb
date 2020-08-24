class UsersController < ApplicationController
	before_action :logged_in_user, only: [:new]
	before_action :check_logged_in, only: [:new, :create]
	before_action :find_user, only: [:correct_user, :show, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
	
	def index
		@users = User.paginate(page: params[:page])
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

	def show 
		@microposts = @user.microposts.order_by_time.paginate(page: params[:page])
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render :edit
		end		
	end

	def destroy
		@user.destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	# Confirms a logged-in user.
	


	private

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in!!!"
			redirect_to login_url		
		end
	end

	def check_logged_in
		if logged_in?
			flash[:danger] = "You are logging..."
			redirect_to root_path
		end		
	end

	# Confirms the correct user.
	def correct_user
		 if  !current_user.current_user?(@user)
		 	flash[:danger] = "Cannot edit other users!!!"
		 	redirect_to @user
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

	# Confirms an admin user.
	def admin_user
		redirect_to(root_url) unless current_user.admin?
		
	end

	def find_user
		@user = User.find_by(id:params[:id])
		if @user.nil?
			flash[:danger] = "User không tồn tại!!!"
			redirect_to root_path
		end
	end

	
end
