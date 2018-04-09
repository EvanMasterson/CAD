class NotifyMailer < ApplicationMailer
  def send_mail(doctor, patient)
    @doctor = doctor
    @patient = patient
    mail(to: doctor.email, subject: 'Patient Added', template_path: 'layouts', template_name: 'notification')
  end
end