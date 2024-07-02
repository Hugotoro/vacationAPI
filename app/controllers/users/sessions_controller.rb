class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      token = JWT.encode({ user_id: resource.id, exp: 3.days.from_now.to_i }, Rails.application.credentials.dig(:devise, :jwt_secret_key))
      render json: { token: token, user: resource }, status: :ok
    else
      render json: { error: 'Invalid Email or Password' }, status: :unauthorized
    end
  end

  def destroy
    sign_out(resource_name)
    head :no_content
  end
end