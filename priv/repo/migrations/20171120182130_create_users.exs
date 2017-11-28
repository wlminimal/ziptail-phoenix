defmodule Ziptail.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"
    create table(:users) do
      add :name, :string
      add :email, :citext

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
