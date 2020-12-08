# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_with_one_test_instance) { create(:user, :examiner_en, test_instance_count: 1) }
  let(:user_with_two_test_instance) { create(:user, :examiner_en, test_instance_count: 2) }

  it 'user_lower_nb_test method return user with the lower number of test assigned in a given record of users' do
    user_lower = user_with_one_test_instance
    user_with_two_test_instance
    expect(User.user_lower_nb_test(User.all)).to eq(user_lower)
  end
end
