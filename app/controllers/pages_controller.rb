class PagesController < ApplicationController
    before_action :authenticate_user!, only: :appointment
    def home
    end
    
    def appointment
        @patient = redirect_to new_patient_path
    end
end
