class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
      user = User.from_omniauth(request.env["omniauth.auth"])
      if user.persisted?
        flash.notice = "Logged in!"
        session[:user_id] = user.id
        sign_in_and_redirect user
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
      end
    end
    alias_method :facebook, :all  
end
