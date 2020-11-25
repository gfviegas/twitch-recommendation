defmodule TRS.Repo do
  use Ecto.Repo,
    otp_app: :trs,
    adapter: Ecto.Adapters.Postgres
end
