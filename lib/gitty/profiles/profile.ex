defmodule Gitty.Profiles.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :bio, :string
    field :company, :string
    field :location, :string
    field :name, :string
    field :twitter_username, :string
    field :website, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:name, :bio, :location, :company, :website, :twitter_username])
    |> validate_required([:user_id])
    |> unique_constraint(:user_id)
  end
end
