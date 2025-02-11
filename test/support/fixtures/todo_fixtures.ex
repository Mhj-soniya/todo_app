defmodule ToDo.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ToDo.Todo` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        text: "some text"
      })
      |> ToDo.Todo.create_task()

    task
  end
end
