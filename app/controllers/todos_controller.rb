class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :destroy]

  def index
    @todos = current_user.todos
    @todo = Todo.new
    @wwr_url = 'https://weworkremotely.com/categories/remote-programming-jobs.rss'
    @remote_ok_url = "https://remoteok.io/api"
    rss_feed(@wwr_url)
    remote_ok_serialized = open(@remote_ok_url).read
    @remote_ok = JSON.parse(remote_ok_serialized)
    @remote_ok_jobs = []
    @remote_ok[1..@remote_ok.length].each do |job|
      @remote_ok_jobs << job
    end
    @remote_ok_jobs
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

  def rss_feed(url)
    if url.include? "https://weworkremotely"
      open(url) do |rss|
        @wwr_feed = RSS::Parser.parse(rss)
      end
    @wwr_feed
    end
  end

  # def remote_ok(url)
  # end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:name, :due_date, :completed)
  end

end
