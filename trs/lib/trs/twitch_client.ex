defmodule TRS.TwitchClient do
  use GenServer

  alias TRS.Streams.Stream

  @authentication_url "https://id.twitch.tv/oauth2/token"
  @streams_url "https://api.twitch.tv/helix/streams"

  # Client
  def start_link(_params \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_token do
    GenServer.call(__MODULE__, :fetch_token)
  end

  def fetch_streams(game_ids) do
    GenServer.call(__MODULE__, {:fetch_streams, game_ids})
  end

  # Callbacks
  @impl true
  def init(_initial_state) do
    {:ok, token} = fetch_token()

    {:ok, %{token: token}}
  end

  @impl true
  def handle_call(:fetch_token, _from, state = %{token: token}) do
    {:reply, {:ok, token}, state}
  end

  @impl true
  def handle_call(:fetch_token, _from, state) do
    {:reply, {:error, :no_token}, state}
  end

  @impl true
  def handle_call({:fetch_streams, game_ids}, _from, state = %{token: token}) do
    headers = format_headers(token)
    params = format_game_ids_params(game_ids)

    case HTTPoison.get(@streams_url, headers, params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{data: streams}} = Jason.decode(body, keys: :atoms)
        streams = Enum.map(streams, &struct(Stream, &1))

        {:reply, {:ok, streams}, state}

      _ ->
        {:reply, {:error, :unable_to_fetch}, state}
    end
  end

  @impl true
  def handle_call({:fetch_streams, _game_ids}, _from, state) do
    {:reply, {:error, :no_token}, state}
  end

  # Autentica na API da Twitch e retorna o token
  defp fetch_token do
    params = [
      client_id: client_id(),
      client_secret: client_secret(),
      grant_type: "client_credentials",
      scope: "analytics:read:games analytics:read:extensions"
    ]

    case response = HTTPoison.post(@authentication_url, "", [], [params: params]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"access_token" => token}} = Jason.decode(body)
        {:ok, token}
      _ ->
        {:error, response}
    end
  end

  defp format_headers(token) do
    [
      "Authorization": "Bearer #{token}",
      "Client-Id": client_id(),
      "Accept": "*/*"
    ]
  end

  defp format_game_ids_params(game_ids) do
    Enum.map(game_ids, fn id -> {:game_id, id} end)
  end

  defp client_id, do: System.fetch_env!("TWITCH_CLIENT_ID")
  defp client_secret, do: System.fetch_env!("TWITCH_CLIENT_SECRET")
end
