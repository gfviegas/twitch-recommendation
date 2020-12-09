defmodule TRSWeb.StreamLive.Index do
  use TRSWeb, :live_view

  alias TRS.Streams
  alias TRS.Streams.Stream

  @interval 30_000

  @impl true
  def mount(_params, _session, socket) do
    # TODO: set interval (atualiza_dados, 30_000)
    Process.send_after(@self, :update_streams, @interval)

    {:ok, assign(socket, :streams, list_streams())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info(:update_streams, socket) do
    {:ok,
      socket
      |> assign(:streams, list_streams)
    }
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Minhas recomendaçÕes")
    |> assign(:stream, nil)
  end

  defp list_streams do
    Streams.list_streams()
  end
end
