defmodule TRS.InterestsTest do
  use TRS.DataCase

  alias TRS.Interests

  describe "user_interests" do
    alias TRS.Interests.Interest

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def interest_fixture(attrs \\ %{}) do
      {:ok, interest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Interests.create_interest()

      interest
    end

    test "list_user_interests/0 returns all user_interests" do
      interest = interest_fixture()
      assert Interests.list_user_interests() == [interest]
    end

    test "get_interest!/1 returns the interest with given id" do
      interest = interest_fixture()
      assert Interests.get_interest!(interest.id) == interest
    end

    test "create_interest/1 with valid data creates a interest" do
      assert {:ok, %Interest{} = interest} = Interests.create_interest(@valid_attrs)
    end

    test "create_interest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Interests.create_interest(@invalid_attrs)
    end

    test "update_interest/2 with valid data updates the interest" do
      interest = interest_fixture()
      assert {:ok, %Interest{} = interest} = Interests.update_interest(interest, @update_attrs)
    end

    test "update_interest/2 with invalid data returns error changeset" do
      interest = interest_fixture()
      assert {:error, %Ecto.Changeset{}} = Interests.update_interest(interest, @invalid_attrs)
      assert interest == Interests.get_interest!(interest.id)
    end

    test "delete_interest/1 deletes the interest" do
      interest = interest_fixture()
      assert {:ok, %Interest{}} = Interests.delete_interest(interest)
      assert_raise Ecto.NoResultsError, fn -> Interests.get_interest!(interest.id) end
    end

    test "change_interest/1 returns a interest changeset" do
      interest = interest_fixture()
      assert %Ecto.Changeset{} = Interests.change_interest(interest)
    end
  end
end
