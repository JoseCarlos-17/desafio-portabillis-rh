require 'rails_helper'

RSpec.describe "Clients::UsersController", type: :request do
  describe 'GET#show' do
    context 'when a client is selected by manager' do
      let!(:client) { create(:user, access_level: "client") }

      before do
        get "/client/users/#{client.id}",
        headers: get_headers(client)
      end

      it 'must to return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must to return client attributes' do
        expect(json_body).to include(:id, :name, :email)
      end
    end
  end

  describe 'PUT#update' do
    context 'when a song is updated by admin' do
      let!(:client) { create(:user, access_level: "client") }
      let(:client_attributes) { attributes_for(:user,  name: 'John doe',
        email: 'johndoe@gmail.com', password: "123123123",
        password_confirmation: "123123123")
      }

      before do
        put "/client/users/#{client.id}",
        params: { client: client_attributes },
        headers: get_headers(client)
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end

      it 'must update the client attributes' do
        expect(User.last.name).to eq('John doe')
      end
    end
  end
end
