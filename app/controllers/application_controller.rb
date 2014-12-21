class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def after_sign_in_path_for(resource)
    return resource.admin? ? admin_path : root_path
  end

  def is_admin?
    return current_user && current_user.admin? ? true : redirect_to(root_url)
  end

  def load_properties
    @properties = Property.all
  end

  def load_users
    @users = User.all
  end

end
