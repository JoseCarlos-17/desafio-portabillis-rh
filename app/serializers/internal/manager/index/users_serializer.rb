class Internal::Manager::Index::UsersSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
