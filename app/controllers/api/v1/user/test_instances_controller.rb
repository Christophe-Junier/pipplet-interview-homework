class Api::V1::User::TestInstancesController < ApplicationController

  def index
    # Retrieving user, role 0 is there to be certain the user is a test taker.
    @user = User.find_by(id: params[:user_id], role: 0)

    # If user doesnt exist or isnt a test taker
    return render json: { message: 'incorrect user id' }, status: 422 if @user.nil?

    # Retrieving all test instances of the user
    @user_test_instances = @user.test_instances

    # Serializing user test instance , to json.
    @data = TestInstanceSerializer.new(@user_test_instances).serializable_hash.to_json

    # Returning data
    return render json: @data, status: 200
  end

  def create
    begin
      test_instance = TestInstance.new(language: params[:language], users: [ User.find_by(id: params[:user_id], role: 0) ])
    rescue ActiveRecord::AssociationTypeMismatch # Catching empty user case
      return render json: 'unvalid user id', status: :unprocessable_entity
    rescue ArgumentError # Catching language error
      return render json: 'unvalid language', status: :unprocessable_entity
    end

    if test_instance.save # Saving test instance
      render json: test_instance, status: :created # If saved responding json with test instance data
      test_instance.update_hash # Then updating hash
    else
      render json: test_instance.errors, status: :unprocessable_entity # Else responding with occuring errors
    end
  end
end
