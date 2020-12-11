defmodule TRSWeb.StreamLive.Index do
  use TRSWeb, :live_view

  alias TRS.Streams
  alias TRS.Streams.Stream
  alias TRS.Accounts

  @interval 30_000
  @thumbnail_url_width "1920"
  @thumbnail_url_height "1080"

  @impl true
  def mount(_params, %{"user_token" => token}, socket) do
    current_user = Accounts.get_user_by_session_token(token)
    streams = list_streams(current_user)

    # TODO: set interval (atualiza_dados, 30_000)
    # Process.send_after(@self, :update_streams, @interval)

    {:ok,
      socket
        |> assign(:streams, streams)
        |> assign(:current_stream, nil)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info(:update_streams, socket = %{current_user: current_user}) do
    {:ok,
      socket
      |> assign(:streams, list_streams(current_user))
    }
  end

  @impl true
  def handle_event("open_stream", %{"stream" => stream}, socket) do
    # stream = struct(Stream, Jason.decode!(stream, keys: :atoms))
    {:noreply, assign(socket, :current_stream, stream)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Dashboard")
    |> assign(:stream, nil)
  end

  defp list_streams(current_user) do
    {:ok, streams} = Streams.list_streams(current_user)

    streams = Enum.map(streams, fn stream = %{thumbnail_url: original_url} ->
        url = original_url
          |> String.replace("{width}", @thumbnail_url_width)
          |> String.replace("{height}", @thumbnail_url_height)

        %Stream{stream | thumbnail_url: url}
      end)

    streams
  end
end
