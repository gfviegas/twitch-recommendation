defmodule TRSWeb.StreamLive.Show do
  use TRSWeb, :live_view

  alias TRS.Streams.Stream

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(stream, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stream, stream)}
  end

  defp page_title(:show), do: "Transmissão"
end
