class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    redirect_to root_url
  end
end
