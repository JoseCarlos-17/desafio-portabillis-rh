class Webhooks::Rh::Create::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :access_level
end
