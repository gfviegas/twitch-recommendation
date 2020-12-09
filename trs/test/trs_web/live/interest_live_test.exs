defmodule TRSWeb.InterestLiveTest do
  use TRSWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TRS.Interests

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:interest) do
    {:ok, interest} = Interests.create_interest(@create_attrs)
    interest
  end

  defp create_interest(_) do
    interest = fixture(:interest)
    %{interest: interest}
  end

  describe "Index" do
    setup [:create_interest]

    test "lists all user_interests", %{conn: conn, interest: interest} do
      {:ok, _index_live, html} = live(conn, Routes.interest_index_path(conn, :index))

      assert html =~ "Listing User interests"
    end

    test "saves new interest", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.interest_index_path(conn, :index))

      assert index_live |> element("a", "New Interest") |> render_click() =~
               "New Interest"

      assert_patch(index_live, Routes.interest_index_path(conn, :new))

      assert index_live
             |> form("#interest-form", interest: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#interest-form", interest: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.interest_index_path(conn, :index))

      assert html =~ "Interest created successfully"
    end

    test "updates interest in listing", %{conn: conn, interest: interest} do
      {:ok, index_live, _html} = live(conn, Routes.interest_index_path(conn, :index))

      assert index_live |> element("#interest-#{interest.id} a", "Edit") |> render_click() =~
               "Edit Interest"

      assert_patch(index_live, Routes.interest_index_path(conn, :edit, interest))

      assert index_live
             |> form("#interest-form", interest: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#interest-form", interest: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.interest_index_path(conn, :index))

      assert html =~ "Interest updated successfully"
    end

    test "deletes interest in listing", %{conn: conn, interest: interest} do
      {:ok, index_live, _html} = live(conn, Routes.interest_index_path(conn, :index))

      assert index_live |> element("#interest-#{interest.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#interest-#{interest.id}")
    end
  end

  describe "Show" do
    setup [:create_interest]

    test "displays interest", %{conn: conn, interest: interest} do
      {:ok, _show_live, html} = live(conn, Routes.interest_show_path(conn, :show, interest))

      assert html =~ "Show Interest"
    end

    test "updates interest within modal", %{conn: conn, interest: interest} do
      {:ok, show_live, _html} = live(conn, Routes.interest_show_path(conn, :show, interest))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Interest"

      assert_patch(show_live, Routes.interest_show_path(conn, :edit, interest))

      assert show_live
             |> form("#interest-form", interest: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#interest-form", interest: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.interest_show_path(conn, :show, interest))

      assert html =~ "Interest updated successfully"
    end
  end
end
