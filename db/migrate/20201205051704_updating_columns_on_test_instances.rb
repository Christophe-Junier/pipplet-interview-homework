class UpdatingColumnsOnTestInstances < ActiveRecord::Migration[6.0]
  change_table :test_instances do |t|
    t.change :language, :int, null: false
  end
end
