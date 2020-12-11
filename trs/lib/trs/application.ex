defmodule TRS.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TRS.Repo,
      # Start the Telemetry supervisor
      TRSWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TRS.PubSub},
      # Start the Endpoint (http/https)
      TRSWeb.Endpoint,
      # Start a worker by calling: TRS.Worker.start_link(arg)
      # {TRS.Worker, arg}

      # Twitch Client
      TRS.TwitchClient
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TRS.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TRSWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
