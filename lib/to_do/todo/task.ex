defmodule ToDo.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :text, :string
    field :completed, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs\\%{}) do
    task
    |> cast(attrs, [:text, :completed])
    |> validate_required([:text])
  end
end
