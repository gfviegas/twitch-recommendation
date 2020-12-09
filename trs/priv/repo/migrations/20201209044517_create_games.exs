defmodule TRS.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :image_url, :string
      add :twitch_id, :integer

      timestamps()
    end

  end
end
