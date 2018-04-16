class Notifier
  def update(doctor, patient)
    if doctor && patient
      DoctorMailer.send_mail(doctor).deliver_now
      PatientMailer.send_mail_doctor(patient).deliver_now
    elsif patient
      PatientMailer.send_mail_appointment(patient).deliver_now
    end
  end
end