defmodule Ziptail.AdministrationTest do
  use Ziptail.DataCase

  alias Ziptail.Administration

  describe "users" do
    alias Ziptail.Administration.User

    @valid_attrs %{email: "some email", name: "some name", phone: "some phone"}
    @update_attrs %{email: "some updated email", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{email: nil, name: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Administration.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Administration.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Administration.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Administration.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Administration.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Administration.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Administration.update_user(user, @invalid_attrs)
      assert user == Administration.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Administration.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Administration.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Administration.change_user(user)
    end
  end

  describe "adminusers" do
    alias Ziptail.Administration.AdminUser

    @valid_attrs %{email: "some email", name: "some name", phone: "some phone"}
    @update_attrs %{email: "some updated email", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{email: nil, name: nil, phone: nil}

    def admin_user_fixture(attrs \\ %{}) do
      {:ok, admin_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Administration.create_admin_user()

      admin_user
    end

    test "list_adminusers/0 returns all adminusers" do
      admin_user = admin_user_fixture()
      assert Administration.list_adminusers() == [admin_user]
    end

    test "get_admin_user!/1 returns the admin_user with given id" do
      admin_user = admin_user_fixture()
      assert Administration.get_admin_user!(admin_user.id) == admin_user
    end

    test "create_admin_user/1 with valid data creates a admin_user" do
      assert {:ok, %AdminUser{} = admin_user} = Administration.create_admin_user(@valid_attrs)
      assert admin_user.email == "some email"
      assert admin_user.name == "some name"
      assert admin_user.phone == "some phone"
    end

    test "create_admin_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Administration.create_admin_user(@invalid_attrs)
    end

    test "update_admin_user/2 with valid data updates the admin_user" do
      admin_user = admin_user_fixture()
      assert {:ok, admin_user} = Administration.update_admin_user(admin_user, @update_attrs)
      assert %AdminUser{} = admin_user
      assert admin_user.email == "some updated email"
      assert admin_user.name == "some updated name"
      assert admin_user.phone == "some updated phone"
    end

    test "update_admin_user/2 with invalid data returns error changeset" do
      admin_user = admin_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Administration.update_admin_user(admin_user, @invalid_attrs)
      assert admin_user == Administration.get_admin_user!(admin_user.id)
    end

    test "delete_admin_user/1 deletes the admin_user" do
      admin_user = admin_user_fixture()
      assert {:ok, %AdminUser{}} = Administration.delete_admin_user(admin_user)
      assert_raise Ecto.NoResultsError, fn -> Administration.get_admin_user!(admin_user.id) end
    end

    test "change_admin_user/1 returns a admin_user changeset" do
      admin_user = admin_user_fixture()
      assert %Ecto.Changeset{} = Administration.change_admin_user(admin_user)
    end
  end
end
