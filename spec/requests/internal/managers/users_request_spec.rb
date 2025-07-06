require 'rails_helper'

RSpec.describe "Internal::Manager::UsersController", type: :request do
  describe 'GET#index' do
    context 'when clients are listed' do
      let!(:clients) {
        create_list(:user, 2, access_level: 'client')
      }

      before do
        get '/internal/manager/users'
      end

      it 'must to return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must to return the first client attributes' do
        expect(json_body[0]).to include(:id, :name, :email)
      end
    end
  end

  describe 'GET#show' do
    context 'when a client is selected by manager' do
      let(:client) { create(:user, access_level: 'client') }

      before do
        get "/internal/manager/users/#{client.id}"
      end

      it 'must to return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must to return client attributes' do
        expect(json_body).to include(:id, :name, :email)
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'when a client is deleted' do
      let!(:client) { create(:user, access_level: 'client') }

      before do
        delete "/internal/manager/users/#{client.id}"
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end

      it 'must to delete the client above' do
        expect(User.where(access_level: 'client').all.count).to eq(0)
      end
    end
  end

  describe 'PUT#inactivate' do
    context 'when a client is inactivated by manager' do
      let!(:client) { create(:user, access_level: 'client') }

      before do
        put "/internal/manager/users/#{client.id}/inactivate"
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
