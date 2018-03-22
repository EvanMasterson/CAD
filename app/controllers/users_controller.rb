class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!
  
  def authenticate_admin!
    redirect_to(root_path) unless current_user.admin
  end
  
  def index
    @users = User.all
  end

  def show
  end
  
  def new
    @user = User.new
  end

  def edit
  end
  
  def create
    @user = User.new(create_user_params)
    if @user.doctor
      puts 'trueeeeeeeeee'
      @doctor = Doctor.new(email: create_user_params[:email])
      @doctor.save
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
        if @user.update(update_user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end
  
  def destroy
    @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :doctor, :patient)
    end
    
    def update_user_params
      params.require(:user).permit(:email, :admin, :doctor, :patient)
    end
end
