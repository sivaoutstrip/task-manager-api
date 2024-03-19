# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, index: true
      t.text :description
      t.integer :status
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
