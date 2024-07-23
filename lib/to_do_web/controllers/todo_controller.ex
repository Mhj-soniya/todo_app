defmodule ToDoWeb.TodoController do
  use ToDoWeb, :controller

  alias ToDo.Todo
  alias ToDo.Todo.Task

  def index(conn, %{"filter" => filter}) do
    task = case filter do
              "completed" -> Todo.list_completed_todos()
              "active" -> Todo.list_active_todos()
              _ -> Todo.list_todos()
          end
    changeset = Task.changeset(%Task{})
    render(conn, :new, changeset: changeset, task: task)
  end

  def new(conn, _param) do
    task = Todo.list_todos()
    changeset = Task.changeset(%Task{})
    render(conn, :new, changeset: changeset, task: task)
  end

  def create(conn, %{"task" => task_params}) do
    task = Todo.list_todos()
    case Todo.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully")
        |> redirect(to: "/todo/new")
      {:error, %Ecto.Changeset{}=changeset} ->
        render(conn, :new, changeset: changeset, task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    {:ok, _task} = Todo.delete_task(task)
    conn
    |> put_flash(:info, "Task deleted successfully")
    |> redirect(to: "/todo/new")
  end

  def update(conn, %{"id" => id}) do
    # IO.inspect("working===================================")
    task = Todo.get_task!(id)
    # IO.inspect(task)
    case Todo.update_task(task, %{"completed" => true}) do
      {:ok, _tasks} ->
        conn
        |> put_flash(:info, "#{task.text} completed.")
        |> redirect(to: "/todo/new")
    end
  end
end
