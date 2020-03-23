class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :destroy]

  def index
    @todos = current_user.todos
    @todo = Todo.new
  end

  def show; end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    if @todo.save
      redirect_to todos_path
    else
      render "new"
    end
  end

  def destroy
    @todo.destroy
    redirect_to
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:name, :due_date, :completed)
  end

end
