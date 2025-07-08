class Client::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_is_client

  def show
    client = current_user

    render json: client,
           serializer: Client::Show::ClientSerializer,
           status: :ok
  end

  def update
    client = current_user

    client.update(client_params)

    head :no_content
  end

  private

  def client_params
    params.require(:client).permit(:name, :email,
                                   :password, :password_confirmation)
  end
end
