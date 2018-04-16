class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index, :new, :create, :destroy]
  
  def authenticate_admin!
    redirect_to(root_path) unless current_user.admin
  end
  
  def index
    @doctors = Doctor.all
  end

  def show
    if params[:doctor_id] && (current_user.doctor || current_user.admin)
      @doctor = Doctor.find(params[:doctor_id])
    end
  end
  
  def new
    @doctor = Doctor.new
    @clinics = Clinic.all
    create_list(@clinics)
  end

  def edit
    @doctor = Doctor.find(params[:id])
    if @doctor.email == current_user.email || current_user.admin
      @clinics = Clinic.all
      create_list(@clinics)
    end
  end
  
  def create
    @doctor = Doctor.new(doctor_params)

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: 'Doctor was successfully created.' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @email = current_user.email
    @doctor = Doctor.find(params[:id])
    if @email == @doctor.email || current_user.admin
      respond_to do |format|
        if @doctor.update(doctor_params)
          format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
          format.json { render :show, status: :ok, location: @doctor }
        else
          format.html { render :edit }
          format.json { render json: @doctor.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @patient, notice: 'You do not have permissions to edit other doctors!'}
        format.json { render :show, status: :created, location: @patient }
      end
    end
  end
  
  def destroy
    @doctor.destroy
      respond_to do |format|
        format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
        format.json { head :no_content }
      end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end
    
    def create_list(clinics)
      @options = []
      clinics.each do |clinic|
        @options.push(clinic.name)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:firstName, :lastName, :email, :clinic, :specialisation)
    end
end
