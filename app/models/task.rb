# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  status      :integer
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  enum status: ['To Do', 'In Progress', 'Done']
  scope :todo_status_length, -> { where('status = ?', 0).length }

  belongs_to :user, inverse_of: :tasks

  validates :title, presence: true
  validates :status, presence: true
end
