defmodule Gitty.Repo.Migrations.AddPfpToProfiles do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :pfp, references(:images, on_delete: :delete_all)
    end
  end
end
