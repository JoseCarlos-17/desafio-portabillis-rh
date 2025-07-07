class Webhooks::Rh::UsersController < ApplicationController
  def create
    client = User.create!(client_params)

    render json: client,
           serializer: Webhooks::Rh::Create::UserSerializer,
           status: :created
  end

  def inactivate
    client = User.find_by(id: params[:id], access_level: 'client')

    client.update(active: false)

    head :no_content
  end

  private

  def client_params
    params.require(:client).permit(:name, :email)
                           .merge!(access_level: 'client')
  end
end
