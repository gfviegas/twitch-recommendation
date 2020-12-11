defmodule TRSWeb.ModalComponent do
  use TRSWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%= @id %>" class="fixed z-10 inset-0 overflow-y-auto"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%= @id %>"
      phx-page-loading>

      <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <div class="fixed inset-0 transition-opacity" aria-hidden="true">
          <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
        </div>

        <!-- This element is to trick the browser into centering the modal contents. -->
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

        <div style="max-width:65vw" class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:w-full" role="dialog" aria-modal="true" aria-labelledby="modal-headline">
          <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
            <%= if @redirect_to do live_redirect raw("&times;"), to: @redirect_to end %>
            <%= if @return_to do live_patch raw("&times;"), to: @return_to end %>
            <%= live_component @socket, @component, @opts %>
          </div>
        </div>

      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    path_to = case socket.assigns.return_to do
      nil -> socket.assigns.redirect_to
      _   -> socket.assigns.return_to
    end
    {:noreply, push_patch(socket, to: path_to)}
  end
end
