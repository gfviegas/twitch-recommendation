defmodule TRSWeb.StreamLive.Show do
  use TRSWeb, :live_component

  alias TRS.Streams.Stream

  @impl true
  def update(%{stream: stream}, socket) do
    stream = struct(Stream, Jason.decode!(stream, keys: :atoms))

    {:ok,
      socket
        |> assign(:stream, stream)
    }
  end

end
