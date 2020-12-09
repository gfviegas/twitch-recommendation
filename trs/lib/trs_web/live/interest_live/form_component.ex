defmodule TRSWeb.InterestLive.FormComponent do
  use TRSWeb, :live_component

  alias TRS.Interests
  alias TRS.Games

  @impl true
  def update(%{interest: interest} = assigns, socket) do
    changeset = Interests.change_interest(interest)
    games = Games.list_games

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:games, games)
    }
  end

  @impl true
  def handle_event("validate", %{"interest" => interest_params}, socket) do
    changeset =
      socket.assigns.interest
      |> Interests.change_interest(interest_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"interest" => interest_params}, socket) do
    save_interest(socket, socket.assigns.action, interest_params)
  end

  defp save_interest(socket, :edit, interest_params) do
    case Interests.update_interest(socket.assigns.interest, interest_params) do
      {:ok, _interest} ->
        {:noreply,
         socket
         |> put_flash(:info, "Interesse atualizado com sucesso")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_interest(socket, :new, interest_params) do
    case Interests.create_interest(interest_params) do
      {:ok, _interest} ->
        {:noreply,
         socket
         |> put_flash(:info, "Interesse criado com sucesso")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
