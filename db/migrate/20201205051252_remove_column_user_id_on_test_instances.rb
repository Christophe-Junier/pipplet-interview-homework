# frozen_string_literal: true

# Removing old relationship between user and test_instances
class RemoveColumnUserIdOnTestInstances < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_instances, :user_id
  end
end
