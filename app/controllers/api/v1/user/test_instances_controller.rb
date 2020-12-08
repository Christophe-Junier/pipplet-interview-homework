# frozen_string_literal: true

# Api crontroller that create or get test_instances of an user
# rubocop:disable Style/ClassAndModuleChildren
class Api::V1::User::TestInstancesController < ApplicationController
  def index
    # If user if found, then render a serialized model of the user test instance
    # Else render a message error
    if (@user = User.find_by(id: params[:user_id], role: 0))
      render json: TestInstanceSerializer.new(@user.test_instances)
                                         .serializable_hash
                                         .to_json
    else
      render json: { message: 'incorrect user id' }, status: :unprocessable_entity
    end
  end

  def create
    begin
      test_instance = TestInstance.new(language: params[:language],
                                       users: [User.find_by(id: params[:user_id], role: 0)])
    rescue ActiveRecord::AssociationTypeMismatch # Catching empty user case
      return render json: 'unvalid user id', status: :unprocessable_entity
    rescue ArgumentError # Catching language error
      return render json: 'unvalid language', status: :unprocessable_entity
    end

    save_test_instance(test_instance)
  end

  private

  def save_test_instance(test_instance)
    if test_instance.save # Saving test instance
      render json: test_instance, status: :created # If saved responding json with test instance data
      test_instance.update_hash # Then updating hash
    else
      render json: test_instance.errors, status: :unprocessable_entity # Else responding with occuring errors
    end
  end
end
# rubocop:enable Style/ClassAndModuleChildren
