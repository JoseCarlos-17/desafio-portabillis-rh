class Internal::Manager::Show::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
