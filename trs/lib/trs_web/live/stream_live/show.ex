defmodule TRSWeb.StreamLive.Show do
  use TRSWeb, :live_view

  alias TRS.Streams

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stream, Streams.get_stream!(id))}
  end

  defp page_title(:show), do: "Transmissão"
end
