defmodule Gitty.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :path, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:images, [:user_id])
  end
end
