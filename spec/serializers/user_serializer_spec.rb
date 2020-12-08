# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer do
  let(:user) { create(:user, :examiner_en, test_instance_count: 1) }

  it 'return a serialized model of an user' do
    @user = user
    serialized_user = UserSerializer.new(user)
                                    .serializable_hash

    expect(serialized_user).to eq(serialized_data_hash)
  end

  def serialized_data_hash
    { "data": { "id": @user.id.to_s,
                "type": :user,
                "attributes": { "language": @user.language,
                                "created_at": @user.created_at,
                                "updated_at": @user.updated_at,
                                "email": @user.email,
                                "name": @user.name,
                                "expert_language": @user.expert_language,
                                "role": @user.role,
                                "status": @user.status } } }
  end
end
