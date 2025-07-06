class Internal::Manager::UsersController < ApplicationController
  def index
    clients = User.where(access_level: 'client').all

    render json: clients,
           each_serializer: Internal::Manager::Index::UsersSerializer,
           status: :ok
  end

  def show
    client = User.find(params[:id])

    render json: client,
           serializer: Internal::Manager::Show::UserSerializer,
           status: :ok
  end

  def destroy
    client = User.find(params[:id])

    client.destroy!

    head :no_content
  end

  def inactivate
    client = User.find(params[:id])

    client.update(active: false)

    head :no_content
  end
end
