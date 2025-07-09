require 'rails_helper'

RSpec.describe "UserFiltersQuery", type: :query do
  context 'where we have all users, without filters' do
    let!(:client1) { create(:user, name: 'MyString1',
      email: 'mystring1@email.com', access_level: 'client') }
    let!(:client2) { create(:user, name: 'MyString2',
      email: 'mystring2@email.com', access_level: 'client') }
    let!(:client3) { create(:user, name: 'MyString3',
      email: 'mystring3@email.com', access_level: 'manager') }
    let!(:clients) { User.all }

    let(:params) { {} }
    let(:query_list) { UserFiltersQuery.new(clients, params).call }

    before do
      query_list
    end

    it 'must return all clients' do
      expect(query_list[0][:email]).to eq('mystring1@email.com')
      expect(query_list[1][:email]).to eq('mystring2@email.com')
    end
  end

  context 'when the manager filter clients list' do
    let!(:client1) { create(:user, name: 'MyString1',
      email: 'mystring1@email.com', access_level: 'client') }
    let!(:client2) { create(:user, name: 'MyString2',
      email: 'mystring2@email.com', access_level: 'client') }
    let!(:client3) { create(:user, name: 'MyString3',
      email: 'mystring3@email.com', access_level: 'manager') }
    let!(:clients) { User.all }

    context 'by name' do
      let!(:params) { { by_name: 'MyString2' } }
      let(:query_list) { UserFiltersQuery.new(clients, params).call }

      before do
        query_list
      end

      it 'must return the attribute name value' do
        expect(query_list[0][:name]).to eq('MyString2')
      end
    end

    context 'by email' do
      let!(:params) { { by_email: 'mystring2@email.com' } }
      let(:query_list) { UserFiltersQuery.new(clients, params).call }

      before do
        query_list
      end

      it 'must return the attribute name value' do
        expect(query_list[0][:email]).to eq('mystring2@email.com')
      end
    end
  end

  context 'when the admin order the list' do
    let!(:client1) { create(:user, name: 'MyString1',
      email: 'mystring1@email.com', access_level: 'client') }
    let!(:client2) { create(:user, name: 'MyString2',
      email: 'mystring2@email.com', access_level: 'client') }
    let!(:client3) { create(:user, name: 'MyString3',
      email: 'mystring3@email.com', access_level: 'manager') }
    let!(:clients) { User.all }

    context 'by email' do
      let!(:params) { { order_by: 'email' } }
      let(:query_list) { UserFiltersQuery.new(clients, params).call }

      before do
        query_list
      end

      it 'must return the attribute name value' do
        expect(query_list[0][:email]).to eq('mystring2@email.com')
        expect(query_list[1][:email]).to eq('mystring1@email.com')
      end
    end

    context 'by name' do
      let!(:params) { { order_by: 'name' } }
      let(:query_list) { UserFiltersQuery.new(clients, params).call }

      before do
        query_list
      end

      it 'must return the attribute name value' do
        expect(query_list[0][:name]).to eq('MyString2')
        expect(query_list[1][:name]).to eq('MyString1')
      end
    end
  end

  context 'when the admin want to see the inactive users' do
    let!(:client1) { create(:user, name: 'MyString1',
      email: 'mystring1@email.com', access_level: 'client') }
    let!(:client2) { create(:user, name: 'MyString2',
      email: 'mystring2@email.com', access_level: 'client') }
    let!(:client3) { create(:user, name: 'MyString3',
      email: 'mystring3@email.com', access_level: 'manager') }
    let!(:client4) { create(:user, name: 'MyString4',
      email: 'mystring4@email.com', access_level: 'client', active: false) }
    let!(:clients) { User.all }

    context 'show inactive users' do
      let!(:params) { { show_inactive: true } }
      let(:query_list) { UserFiltersQuery.new(clients, params).call }

      before do
        query_list
      end

      it 'must return the attribute name value' do
        expect(query_list[0][:email]).to eq('mystring4@email.com')
      end
    end
  end
end