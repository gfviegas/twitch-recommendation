defmodule TRSWeb.StreamLiveTest do
  use TRSWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TRS.Streams

  @create_attrs %{game_id: 42, game_name: "some game_name", language: "some language", started_at: ~N[2010-04-17 14:00:00], thumbnail_url: "some thumbnail_url", title: "some title", type: "some type", user_id: 42, user_name: "some user_name", viewer_count: 42}
  @update_attrs %{game_id: 43, game_name: "some updated game_name", language: "some updated language", started_at: ~N[2011-05-18 15:01:01], thumbnail_url: "some updated thumbnail_url", title: "some updated title", type: "some updated type", user_id: 43, user_name: "some updated user_name", viewer_count: 43}
  @invalid_attrs %{game_id: nil, game_name: nil, language: nil, started_at: nil, thumbnail_url: nil, title: nil, type: nil, user_id: nil, user_name: nil, viewer_count: nil}

  defp fixture(:stream) do
    {:ok, stream} = Streams.create_stream(@create_attrs)
    stream
  end

  defp create_stream(_) do
    stream = fixture(:stream)
    %{stream: stream}
  end

  describe "Index" do
    setup [:create_stream]

    test "lists all streams", %{conn: conn, stream: stream} do
      {:ok, _index_live, html} = live(conn, Routes.stream_index_path(conn, :index))

      assert html =~ "Listing Streams"
      assert html =~ stream.game_name
    end

    test "saves new stream", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.stream_index_path(conn, :index))

      assert index_live |> element("a", "New Stream") |> render_click() =~
               "New Stream"

      assert_patch(index_live, Routes.stream_index_path(conn, :new))

      assert index_live
             |> form("#stream-form", stream: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#stream-form", stream: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.stream_index_path(conn, :index))

      assert html =~ "Stream created successfully"
      assert html =~ "some game_name"
    end

    test "updates stream in listing", %{conn: conn, stream: stream} do
      {:ok, index_live, _html} = live(conn, Routes.stream_index_path(conn, :index))

      assert index_live |> element("#stream-#{stream.id} a", "Edit") |> render_click() =~
               "Edit Stream"

      assert_patch(index_live, Routes.stream_index_path(conn, :edit, stream))

      assert index_live
             |> form("#stream-form", stream: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#stream-form", stream: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.stream_index_path(conn, :index))

      assert html =~ "Stream updated successfully"
      assert html =~ "some updated game_name"
    end

    test "deletes stream in listing", %{conn: conn, stream: stream} do
      {:ok, index_live, _html} = live(conn, Routes.stream_index_path(conn, :index))

      assert index_live |> element("#stream-#{stream.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#stream-#{stream.id}")
    end
  end

  describe "Show" do
    setup [:create_stream]

    test "displays stream", %{conn: conn, stream: stream} do
      {:ok, _show_live, html} = live(conn, Routes.stream_show_path(conn, :show, stream))

      assert html =~ "Show Stream"
      assert html =~ stream.game_name
    end

    test "updates stream within modal", %{conn: conn, stream: stream} do
      {:ok, show_live, _html} = live(conn, Routes.stream_show_path(conn, :show, stream))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Stream"

      assert_patch(show_live, Routes.stream_show_path(conn, :edit, stream))

      assert show_live
             |> form("#stream-form", stream: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#stream-form", stream: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.stream_show_path(conn, :show, stream))

      assert html =~ "Stream updated successfully"
      assert html =~ "some updated game_name"
    end
  end
end
