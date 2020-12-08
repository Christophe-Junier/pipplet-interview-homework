# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TestInstance, type: :model do
  let(:test_instance)    { create(:test_instance, :fr) }
  let(:valid_examiner)   { create(:user, :examiner, :examiner_validated, :examiner_fr) }
  let(:unvalid_examiner) { create(:user, :examiner, :examiner_rejected, :examiner_fr) }

  it 'update status hash if update_hash method is called' do
    @test_instance = test_instance
    expect(@test_instance.status_hash).to eq(nil)
    @test_instance.update_hash
    expect(@test_instance.status_hash).to_not eq(nil)
  end

  it 'assert existence of language if assert_existence method is called' do
    expect(TestInstance.assert_existence('fr')).to eq(true)
    expect(TestInstance.assert_existence('ge')).to eq(false)
  end

  it 'assign examiner if method is called assign_examiner and an examiner is found' do
    @test_instance = test_instance
    valid_examiner
    expect(@test_instance.users.count).to eq(0)
    @test_instance.assign_examiner
    expect(@test_instance.users.count).to eq(1)
  end

  it 'not assign examiner if method is called assign_examiner and an examiner is not found' do
    @test_instance = test_instance
    unvalid_examiner
    expect(@test_instance.users.count).to eq(0)
    @test_instance.assign_examiner
    expect(@test_instance.users.count).to eq(0)
  end
end
