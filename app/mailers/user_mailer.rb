class UserMailer < ActionMailer::Base
  default from: "admin@viadeca.com"

  def contact_submission(name, email, content)
    @name = name
    @email = email
    @content = content
    mail(:to => User.admin.map(&:email).join(", "),
         :bcc => "teo.dellamico@gmail.com",
         :subject => "Message from ViaDeca.com - Contact Inquiry")
  end
end
