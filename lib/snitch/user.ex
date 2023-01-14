defmodule Snitch.User do
  use Ecto.Schema

  schema "users" do
    field :user_id, :string
    field :name, :string
    field :email, :string
    field :password, :string
  end
end
