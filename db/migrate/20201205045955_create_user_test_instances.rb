# frozen_string_literal: true

# Creating joining Table between users and test_instances
class CreateUserTestInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :user_test_instances do |t|
      t.belongs_to :user
      t.belongs_to :test_instance
      t.timestamps
    end
  end
end
