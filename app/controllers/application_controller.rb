class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
    before_action :configure_permitted_parameters, if: :devise_controller?

      protected

      def configure_permitted_parameters
      [:sign_up, :account_update].each do |sanitize_me|
          devise_parameter_sanitizer.for(sanitize_me) do |u|
            u.permit(:name, :password,:password_confirmation, :email, :birthdate, :introduction,:current_password)
          end
        end
      end
      
end
