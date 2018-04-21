require 'observer'
class PatientsController < ApplicationController
  include Observable
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :observer, only: [:create, :add_patient_to_doctor]
  before_action :authenticate_admin!, only: [:index, :add_patient_to_doctor]
  
  def authenticate_admin!
    unless current_user.admin || current_user.doctor
      flash[:notice] = "You do not have sufficient permissions"
      redirect_to root_path
    end
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
    unless current_user.admin
      if current_user.email != @patient.email
        flash[:notice] = "You do not have sufficient permissions"
        redirect_to root_path
      end
    else
      if params[:doctor_id] && (current_user.doctor || current_user.admin)
        @doctor = Doctor.find(params[:doctor_id])
        @patient = @doctor.patients.find(params[:id])
      end
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
    unless current_user.admin
      if current_user.email != @patient.email
        flash[:notice] = "You do not have sufficient permissions"
        redirect_to root_path
      end
    end
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    if !User.exists?(email: patient_params[:email])
      respond_to do |format|
        format.html { redirect_to new_user_path, notice: 'Patient record cannot be created without associated User!' }
      end
    else
      set_category
      respond_to do |format|
        if @patient.save
          changed
          notify_observers(nil, @patient)
          format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
          format.json { render :show, status: :created, location: @patient }
        else
          format.html { render :new }
          format.json { render json: @patient.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    @email = current_user.email
    @patient = Patient.find(params[:id])
    @patient_email = @patient.email
    set_category
    if @email == @patient.email || current_user.admin
      respond_to do |format|
        if @patient.update(patient_params)
          if User.find_by_email(@patient_email)
            @user = User.find_by_email(@patient_email)
            @user.skip_reconfirmation!
            @user.update(email: patient_params[:email])
          end
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
  
  def set_category
    @patient.category = AgeGroup.setAgeCategory(@patient.dob.to_s)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      if !Patient.exists?(params[:id])
        flash[:notice] = "Patient does not exist"
        redirect_to patients_path
      else
        @patient = Patient.find(params[:id])
      end
    end
    
    def observer
      add_observer(Notifier.new)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:firstName, :lastName, :email, :dob, :address, :phone, :symptom, :category)
    end
end
