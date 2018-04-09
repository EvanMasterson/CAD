class Notifier
  def update(doctor, patient)
    NotifyMailer.send_mail(doctor, patient).deliver_now
  end
end