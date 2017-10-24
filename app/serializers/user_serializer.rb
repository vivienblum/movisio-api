# DEPRECATED
class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :image, :created_at, :updated_at
end
