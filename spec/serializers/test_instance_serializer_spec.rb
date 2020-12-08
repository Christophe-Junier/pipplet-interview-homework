# frozen_string_literal: true

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestInstanceSerializer do
  let(:test_instance) { create(:test_instance, :en) }

  it 'return a serialized model of test_instance' do
    @test_instance = test_instance
    serialized_test_instance = TestInstanceSerializer.new(test_instance)
                                                     .serializable_hash

    expect(serialized_test_instance).to eq(serialized_data_hash)
  end

  def serialized_data_hash
    { "data": { "id": @test_instance.id.to_s,
                "type": :test_instance,
                "attributes": { "language": @test_instance.language,
                                "status_hash": nil,
                                "created_at": @test_instance.created_at,
                                "updated_at": @test_instance.updated_at } } }
  end
end
