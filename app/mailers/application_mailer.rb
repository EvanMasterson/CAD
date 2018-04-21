class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@healthapp.com'
  layout 'mailer'
end
