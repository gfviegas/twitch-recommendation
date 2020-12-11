defmodule TRSWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `TRSWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, TRSWeb.InterestLive.FormComponent,
        id: @interest.id || :new,
        action: @live_action,
        interest: @interest,
        return_to: Routes.interest_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    return_path = case Keyword.fetch(opts, :return_to) do
      {:ok, value} -> value
      :error -> nil
    end
    redirect_path = case Keyword.fetch(opts, :redirect_to) do
      {:ok, value} -> value
      :error -> nil
    end
    modal_opts = [id: :modal, return_to: return_path, redirect_to: redirect_path, component: component, opts: opts]
    live_component(socket, TRSWeb.ModalComponent, modal_opts)
  end
end
