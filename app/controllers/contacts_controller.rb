class ContactsController < ApplicationController

  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.create(contact_params)
    if @contact
      @contact.send_email
      flash[:notice] = "Message successfully delivered!"
      return redirect_to contacts_path
    else
      flash[:danger] = "Sorry, there was a problem with your message. Please try again."
      return render 'contact'
    end
  end


  private
  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
