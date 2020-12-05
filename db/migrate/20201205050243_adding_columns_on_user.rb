class AddingColumnsOnUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :status, :int, null: true
    add_column :users, :expert_language, :int, null: true
  end
end
