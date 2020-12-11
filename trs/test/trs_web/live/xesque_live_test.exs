defmodule TRSWeb.XesqueLiveTest do
  use TRSWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TRS.Xesques

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:xesque) do
    {:ok, xesque} = Xesques.create_xesque(@create_attrs)
    xesque
  end

  defp create_xesque(_) do
    xesque = fixture(:xesque)
    %{xesque: xesque}
  end

  describe "Index" do
    setup [:create_xesque]

    test "lists all xesques", %{conn: conn, xesque: xesque} do
      {:ok, _index_live, html} = live(conn, Routes.xesque_index_path(conn, :index))

      assert html =~ "Listing Xesques"
      assert html =~ xesque.name
    end

    test "saves new xesque", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.xesque_index_path(conn, :index))

      assert index_live |> element("a", "New Xesque") |> render_click() =~
               "New Xesque"

      assert_patch(index_live, Routes.xesque_index_path(conn, :new))

      assert index_live
             |> form("#xesque-form", xesque: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#xesque-form", xesque: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.xesque_index_path(conn, :index))

      assert html =~ "Xesque created successfully"
      assert html =~ "some name"
    end

    test "updates xesque in listing", %{conn: conn, xesque: xesque} do
      {:ok, index_live, _html} = live(conn, Routes.xesque_index_path(conn, :index))

      assert index_live |> element("#xesque-#{xesque.id} a", "Edit") |> render_click() =~
               "Edit Xesque"

      assert_patch(index_live, Routes.xesque_index_path(conn, :edit, xesque))

      assert index_live
             |> form("#xesque-form", xesque: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#xesque-form", xesque: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.xesque_index_path(conn, :index))

      assert html =~ "Xesque updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes xesque in listing", %{conn: conn, xesque: xesque} do
      {:ok, index_live, _html} = live(conn, Routes.xesque_index_path(conn, :index))

      assert index_live |> element("#xesque-#{xesque.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#xesque-#{xesque.id}")
    end
  end

  describe "Show" do
    setup [:create_xesque]

    test "displays xesque", %{conn: conn, xesque: xesque} do
      {:ok, _show_live, html} = live(conn, Routes.xesque_show_path(conn, :show, xesque))

      assert html =~ "Show Xesque"
      assert html =~ xesque.name
    end

    test "updates xesque within modal", %{conn: conn, xesque: xesque} do
      {:ok, show_live, _html} = live(conn, Routes.xesque_show_path(conn, :show, xesque))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Xesque"

      assert_patch(show_live, Routes.xesque_show_path(conn, :edit, xesque))

      assert show_live
             |> form("#xesque-form", xesque: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#xesque-form", xesque: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.xesque_show_path(conn, :show, xesque))

      assert html =~ "Xesque updated successfully"
      assert html =~ "some updated name"
    end
  end
end
