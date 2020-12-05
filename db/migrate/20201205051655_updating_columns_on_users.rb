class UpdatingColumnsOnUsers < ActiveRecord::Migration[6.0]
  change_table :users do |t|
    t.change :language, :int, null: false, default: 0
  end
end
