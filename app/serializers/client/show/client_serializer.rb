class Client::Show::ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
