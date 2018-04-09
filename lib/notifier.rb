class Notifier
  def update(doctor, patient)
    # Will be used to send email notifications
    puts doctor.email + " has new patient: " + patient.email
  end
end