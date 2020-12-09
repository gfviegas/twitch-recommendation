defmodule TRSWeb.InterestLive.Index do
  use TRSWeb, :live_view

  alias TRS.Accounts
  alias TRS.Interests
  alias TRS.Interests.Interest

  @impl true
  def mount(_params, %{"user_token" => token}, socket) do
    current_user = Accounts.get_user_by_session_token(token)

    {:ok, socket
      |> assign(:user_interests, list_user_interests(current_user))
      |> assign(:current_user, current_user)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Alterar Interesse")
    |> assign(:interest, Interests.get_interest!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Novo Interesse")
    |> assign(:interest, %Interest{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Interesses do Usuário")
    |> assign(:interest, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    interest = Interests.get_interest!(id)
    {:ok, _} = Interests.delete_interest(interest)

    {:noreply, assign(socket, :user_interests, list_user_interests(socket.current_user))}
  end

  defp list_user_interests(current_user) do
    Interests.list_user_interests(current_user.id)
  end
end
