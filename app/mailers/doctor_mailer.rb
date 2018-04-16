class DoctorMailer < ApplicationMailer
  def send_mail(doctor)
    @doctor = doctor
    if @doctor
      mail(to: @doctor.email, subject: 'Patient Assigned', template_path: 'layouts', template_name: 'doctor_notification')
    end
  end
end