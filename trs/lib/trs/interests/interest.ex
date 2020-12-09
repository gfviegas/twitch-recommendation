defmodule TRS.Interests.Interest do
  use Ecto.Schema
  import Ecto.Changeset

  alias TRS.Accounts.User
  alias TRS.Games.Game

  schema "user_interests" do
    belongs_to :game, Game, foreign_key: :game_id
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(interest, attrs) do
    interest
    |> cast(attrs, [:game_id, :user_id])
    |> validate_required([:game_id, :user_id])
    |> cast_assoc(:game)
    |> cast_assoc(:user)
  end
end
