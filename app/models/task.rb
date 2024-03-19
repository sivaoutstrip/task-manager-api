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
  enum status: { to_do: 0, in_progress: 1, done: 2 }

  scope :todo, -> { where(status: :to_do) }
  scope :in_progress, -> { where(status: :in_progress) }
  scope :done, -> { where(status: :done) }
  scope :todo_length, -> { to_do.length }

  belongs_to :user, inverse_of: :tasks

  validates :title, presence: true
  validates :status, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title status]
  end

  def self.ransackable_associations(auth_object = nil)
    %i[user]
  end

  def self.ransackable_scopes(auth_object = nil)
    %i[todo in_progress don todo_length]
  end
end
