class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: :home
    
    def home
        @clinics = Clinic.all
    end
    
    def appointment
        @patient = redirect_to new_patient_path
    end
    
    def profile
        if current_user.patient
            @patient = Patient.find_by_email(current_user.email)
            @user = User.find_by_email(current_user.email)
        elsif current_user.doctor
            @doctor = Doctor.find_by_email(current_user.email)
            @user = User.find_by_email(current_user.email)
        else
            @users = User.all
            @doctors = Doctor.all
            @patients = Patient.all
        end
    end
end
