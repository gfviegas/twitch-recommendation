defmodule TRS.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TRS.Accounts` context.
  """

  def valid_user_name, do: "usuario fulaninho de tal"
  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "HelloWorld@123"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: valid_user_name(),
        email: unique_user_email(),
        password: valid_user_password()
      })
      |> TRS.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end
