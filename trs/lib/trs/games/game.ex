defmodule TRS.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :image_url, :string
    field :name, :string
    field :twitch_id, :integer

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :image_url, :twitch_id])
    |> validate_required([:name, :image_url, :twitch_id])
  end
end
