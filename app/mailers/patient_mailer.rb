class PatientMailer < ApplicationMailer
  def send_mail_doctor(patient)
    @patient = patient
    if @patient
      mail(to: @patient.email, subject: 'Doctor Assigned', template_path: 'layouts', template_name: 'patient_notification')
    end
  end
  
  def send_mail_appointment(patient)
    @patient = patient
    if @patient
      mail(to: @patient.email, subject: 'Appointment Created', template_path: 'layouts', template_name: 'appointment')
    end
  end
end