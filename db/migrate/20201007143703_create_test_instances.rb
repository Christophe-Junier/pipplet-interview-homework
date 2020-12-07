# frozen_string_literal: true

# Creating test_instance Table
class CreateTestInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :test_instances do |t|
      t.integer :user_id
      t.string :status_hash
      t.string :language

      t.timestamps
    end
  end
end
