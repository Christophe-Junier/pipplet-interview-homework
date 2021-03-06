# frozen_string_literal: true

# Creating user Table
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role, default: 0
      t.string :language

      t.timestamps
    end
  end
end
