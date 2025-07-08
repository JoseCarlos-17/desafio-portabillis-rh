require 'rails_helper'

RSpec.describe "Webhooks::Rh::UsersController", type: :request do
  describe 'POST#create' do
    context 'when the rh register the client' do
      let(:client_attributes) { attributes_for(:user,  name: 'John doe',
        email: 'johndoe@gmail.com', password: "123123123",
        password_confirmation: "123123123")
      }
      
      before do
        post '/webhooks/rh/users', params: { client: client_attributes }
      end

      it 'must return 201 created status code' do
        expect(response).to have_http_status(:created)
      end

      it 'must return created client attributes' do
        expect(json_body).to include(:id, :name, :email, :access_level)
      end
    end
  end

  describe 'PUT#inactivate' do
    context 'when a client is inactivated by rh' do
      let!(:client) { create(:user, access_level: 'client') }

      before do
        put "/webhooks/rh/users/#{client.id}/inactivate"
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end

      it 'must update the active attribute to false value' do
        expect(User.where(access_level: 'client').last.active).to eq(false)
      end
    end
  end
end
