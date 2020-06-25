class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
      when User
        flash[:notice] = "#{resource.name}さんの投稿を楽しみにしています！"
        root_path(resource)
      when Admin
        admins_animes_path
      end
  end
  
  def after_sign_out_path_for(resource)
    if resource != :admin
      root_path
    else
      new_admin_session_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
