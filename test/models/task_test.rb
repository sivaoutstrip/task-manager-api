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
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = Task.new(title: 'My todo', description: 'My todo description', status: 0, user_id: users(:user_one).id)
  end

  test 'should not create task without user' do
    @task.user_id = nil
    assert_not @task.save
  end

  test 'should not create task without title' do
    @task.title = nil
    assert_not @task.save
  end

  test 'should not create task without status' do
    @task.status = nil
    assert_not @task.save
  end

  test 'create task with valid params' do
    assert @task.save
  end
end
