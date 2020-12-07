# frozen_string_literal: true

# adding a test_instance counter for each users.
class AddColumnColumnTestInstanceCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :test_instance_count, :int, null: false, default: 0
  end
end
