require 'rails_helper'

RSpec.describe 'Auth::SessionsController', type: :request do
  describe 'POST#sign_in' do
    context 'when a registrated user log in' do
      let!(:client) { create(:user, email: "userefg@email.com",
        password: "12345678", password_confirmation: "12345678") }

      let(:client_params) { { email: "userefg@email.com",
        password: "12345678" } }

      before do
        post '/auth/sign_in', params: client_params
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the login response attributes' do
        expect(json_body[:data]).to include(:email, :provider, :uid, :id,
                                            :name)
      end
    end
  end
end