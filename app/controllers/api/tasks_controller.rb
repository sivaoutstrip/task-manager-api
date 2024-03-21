# frozen_string_literal: true

module Api
  class TasksController < ApplicationController
    before_action :set_task

    def index
      @q = Task.ransack(params[:q])
      @tasks = @q.result.where(user: @current_user).order(created_at: :desc)
      render :index, status: :ok
    end

    def create
      if todo_status_overdue?
        message = 'Unforunately there more than 50% tasks are in todo\'s status. Please complete some of them to create new tasks'
        return render json: { message: }, status: :unprocessable_entity
      end

      @task = @current_user.tasks.new(tasks_params)
      return render json: { messages: @task.errors.full_messsages }, status: :unprocessable_entity unless @task.save

      render :show, status: :created
    end

    def show
      render :show, status: :ok
    end

    def update
      return render json: { messages: 'Task not found' } if @task.nil?

      @task.update(tasks_params)
      render :show, status: :ok
    end

    def destroy
      return render json: { messages: 'Task not found' } if @task.nil?

      @task.destroy
      render json: { id: @task.id }, status: :ok
    end

    private

    def todo_status_overdue?
      users_tasks = Task.where(user: @current_user)
      total_tasks = users_tasks.length
      return false if total_tasks <= 5

      todos_count = users_tasks.todo_length.to_f

      (todos_count / total_tasks) >= 0.5
    end

    def set_task
      @task = Task.find_by(id: params[:id], user: @current_user)
    end

    def tasks_params
      params.permit(:user_id, :title, :description, :status)
    end

    def ransack_params
      params.permit(:status_eq)
    end
  end
end
