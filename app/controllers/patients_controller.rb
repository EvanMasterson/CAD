require 'observer'
class PatientsController < ApplicationController
  include Observable
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :observer, only: [:add_patient_to_doctor]
  before_action :authenticate_admin!, only: [:index, :add_patient_to_doctor]
  
  def authenticate_admin!
    redirect_to(root_path) unless current_user.admin || current_user.doctor
  end

  # GET /patients
  # GET /patients.json
  def index
    if params[:doctor_id] && (current_user.doctor || current_user.admin)
      @doctor = Doctor.find(params[:doctor_id])
      @patients = @doctor.patients
    else
      @patients = Patient.all
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    if params[:doctor_id] && (current_user.doctor || current_user.admin)
      @doctor = Doctor.find(params[:doctor_id])
      @patient = @doctor.patients.find(params[:id])
    end
  end

  # GET /patients/new
  def new
    if Patient.exists?(email: current_user.email)
      @email = @current_user.email
      @patient = Patient.find_by_email(@email)
      respond_to do |format|
        format.html { redirect_to @patient, notice: 'Patient record already exists for: ' + @email}
        format.json { render :show, status: :created, location: @patient }
      end
    else
      @patient = Patient.new
    end
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    @email = current_user.email
    @patient = Patient.find(params[:id])
    if @email == @patient.email || current_user.admin
      respond_to do |format|
        if @patient.update(patient_params)
          format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
          format.json { render :show, status: :ok, location: @patient }
        else
          format.html { render :edit }
          format.json { render json: @patient.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @patient, notice: 'You do not have permissions to edit other patients!'}
        format.json { render :show, status: :created, location: @patient }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @email = current_user.email
    @patient = Patient.find(params[:id])
    
    if params[:doctor_id] && (current_user.doctor || current_user.admin)
      @doctor = Doctor.find(params[:doctor_id])
      @patient = @doctor.patients.find(params[:id])
      @doctor.patients.delete(@patient)
      
      respond_to do |format|
        format.html { redirect_to @doctor, notice: 'Patient was successfully removed.' }
        format.json { head :no_content }
      end
    elsif @email == @patient.email || current_user.admin
      @patient.destroy
      respond_to do |format|
        format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @patient, notice: 'You do not have permissions to delete other patients!'}
        format.json { render :show, status: :created, location: @patient }
      end
    end
  end
  
  def add_patient_to_doctor
    @doctor = Doctor.find(params[:doctor_id])
    @patient_id = params[:patient_id]
    @patient = Patient.find(@patient_id)
    
    respond_to do |format|
      if @patient.save
        @doctor.patients << @patient
        changed
        notify_observers(@doctor, @patient)
        format.html { redirect_to @doctor, notice: 'Patient successfully added to Doctor.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end
    
    def observer
      add_observer(Notifier.new)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:firstName, :lastName, :email, :dob, :address, :phone, :symptom)
    end
end
