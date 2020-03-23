class TodosController < ApplicationController

  def index
    @todos = current_user.todos
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :completed, )
  end


end
