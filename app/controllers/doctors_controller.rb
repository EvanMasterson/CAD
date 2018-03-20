class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  def authenticate_admin!
    redirect_to(root_path) unless current_user.admin
  end
  
  def index
    @doctors = Doctor.all
  end

  def show
  end
  
  def new
    @doctor = Doctor.new
  end

  def edit
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
    respond_to do |format|
        if @doctor.update(doctor_params)
          format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
          format.json { render :show, status: :ok, location: @doctor }
        else
          format.html { render :edit }
          format.json { render json: @doctor.errors, status: :unprocessable_entity }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:firstName, :lastName, :clinic, :specialisation)
    end
end
