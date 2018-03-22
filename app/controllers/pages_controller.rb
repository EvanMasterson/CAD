class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: :home
    
    def home
    end
    
    def appointment
        @patient = redirect_to new_patient_path
    end
end
