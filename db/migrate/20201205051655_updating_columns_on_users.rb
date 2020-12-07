# frozen_string_literal: true

# updating user language to int with no null allowed and default value to 0
class UpdatingColumnsOnUsers < ActiveRecord::Migration[6.0]
  change_table :users do |t|
    t.change :language, :int, null: false, default: 0
  end
end
