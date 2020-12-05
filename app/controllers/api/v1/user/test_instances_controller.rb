class Api::V1::User::TestInstancesController < ApplicationController

  def index
    # Retrieving user, role 0 is there to be certain the user is a test taker.
    @user = User.find_by(id: params[:user_id], role: 0)

    # If user doesnt exist or isnt a test taker
    return render json: { message: 'incorrect user id' }, status: 422 if @user.nil?

    @user_test_instances = @user.test_instances
    @data = TestInstanceSerializer.new(@user_test_instances).serializable_hash.to_json
    return render json: @data, status: 200
  end

  def create
    # Retrieving user, role 0 is there to be certain the user is a test taker.
    @user = User.find_by(id: params[:user_id], role: 0)

    # If user doesnt exist or isnt a test taker
    return render json: { message: 'incorrect user id' }, status: 422 if @user.nil?

    # A little bit tricky, due to enum taking over all kind of errors, we need to manually test if the language is uncorrect.
    return  render json: { message: 'incorrect language' }, status: 422 unless TestInstance.assert_existence(params[:language])

    # Initializing a new test instance and its user
    @test_instance = TestInstance.new(test_instance_params)
    @test_instance.users << @user

    # Saving
    return render json: { message: 'test instance created' }, status: 200 if @test_instance.save
  end

  private

  def test_instance_params
    params.require(:test_instance).permit(:language, :user_id)
  end

end
