# frozen_string_literal: true

class TestInstanceSerializer
  include JSONAPI::Serializer
  attributes :language, :status_hash, :created_at, :updated_at

  # Uncomment to also have associated user to each test instance
  # has_many :users
end
