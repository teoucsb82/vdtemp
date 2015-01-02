class Contact < ActiveRecord::Base
  validates :name, :email, :content, :presence => true

  def send_email
    UserMailer.contact_submission(name, email, content).deliver
  end
end
