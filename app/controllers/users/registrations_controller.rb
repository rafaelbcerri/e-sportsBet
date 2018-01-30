class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    resource.discard
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    redirect_to root_url
  end

  protected

  def update_resource(resource, params)
    return super if params["password"]&.present?
    resource.update_without_password(params.except("current_password"))
  end

  def after_update_path_for(resource)
    bets_path(resource)
  end
end
