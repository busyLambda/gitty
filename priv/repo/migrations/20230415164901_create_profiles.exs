defmodule Gitty.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :name, :string
      add :bio, :string
      add :location, :string
      add :company, :string
      add :website, :string
      add :twitter_username, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:profiles, [:user_id])
  end
end
