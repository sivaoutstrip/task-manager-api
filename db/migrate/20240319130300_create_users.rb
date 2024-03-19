# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, index: true
      t.string :password
      t.string :password_confirmation
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
