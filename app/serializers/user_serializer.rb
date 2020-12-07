# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :role, :language, :status, :expert_language, :created_at, :updated_at
end
