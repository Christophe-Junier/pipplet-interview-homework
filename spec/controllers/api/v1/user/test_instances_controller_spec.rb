# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API V1 USER TEST_INSTANCES', type: 'request' do
  describe 'POST /user/test_instances' do
    context 'with valid parameters' do
      let(:valid_params) { { user_id: User.first.id, language: 'fr' } }
      let(:user) { create(:user, :test_taker) }

      it 'creates a new test_instance' do
        user
        expect { post '/user/test_instances', params: valid_params }.to change(TestInstance, :count).by(+1)
        expect(response).to have_http_status :created
      end
    end

    context 'with unvalid language' do
      let(:unvalid_param_language) { { user_id: 1, language: 'op' } }

      it 'doesnt creates a new test_instance' do
        expect { post '/user/test_instances', params: unvalid_param_language }.to_not change(TestInstance, :count)
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'with unvalid id' do
      let(:unvalid_param_user_id) { { user_id: 100, language: 'fr' } }

      it 'doesnt creates a new test_instance' do
        expect { post '/user/test_instances', params: unvalid_param_user_id }.to_not change(TestInstance, :count)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET /user/test_instances?user_id' do
    context 'with valid user id' do
      let(:user) { create(:user, :test_taker) }

      it 'respond ok' do
        user
        get '/user/test_instances?user_id=1'
        expect(response).to have_http_status :ok
      end
    end

    context 'with unvalid user id' do
      it 'respond unprocessable_entity' do
        get '/user/test_instances?user_id=2'
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
