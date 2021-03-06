class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show, :edit, :update]
  
  def authenticate_admin!
    unless current_user.admin
      flash[:notice] = "You do not have sufficient permissions"
      redirect_to root_path
    end
  end
  
  def index
    @users = User.all
  end

  def show
    unless current_user.admin
      if current_user.email != @user.email
        flash[:notice] = "You do not have sufficient permissions"
        redirect_to root_path
      end
    end
  end
  
  def new
    @user = User.new
  end

  def edit
    unless current_user.admin
      if current_user.email != @user.email
        flash[:notice] = "You do not have sufficient permissions"
        redirect_to root_path
      end
    end
  end
  
  def create
    @user = User.new(create_user_params)
    if @user.doctor
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
    @email = @user.email
    if !current_user.admin
      @user.skip_reconfirmation!
    end
    respond_to do |format|
        if @user.update(update_user_params)
          if Patient.find_by_email(@email)
            @patient = Patient.find_by_email(@email)
            @patient.update(email: update_user_params[:email])
          elsif Doctor.find_by_email(@email)
            @doctor = Doctor.find_by_email(@email)
            @doctor.update(email: update_user_params[:email])
          end
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
      if !User.exists?(params[:id])
        flash[:notice] = "User does not exist"
        redirect_to users_path
      else
        @user = User.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :doctor, :patient, :dob, :address, :phone, :firstName, :lastName)
    end
    
    def update_user_params
      params.require(:user).permit(:email, :admin, :doctor, :patient, :dob, :address, :phone, :firstName, :lastName)
    end
end
