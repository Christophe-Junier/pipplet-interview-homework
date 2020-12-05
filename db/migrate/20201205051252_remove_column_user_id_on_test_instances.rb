class RemoveColumnUserIdOnTestInstances < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_instances, :user_id
  end
end
