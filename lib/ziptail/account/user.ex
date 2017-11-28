defmodule Ziptail.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ziptail.Account.User

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/, message: "is invalid")
    |> unique_constraint(:email)
  end

  defp put_hashed_password(changeset) do
  	case changeset.valid? do
  	  true ->
  	    changes = changeset.changes
  	    put_change(changeset, :password_hash, hashpwsalt(changes.password))
  	  _    ->
  	  	changeset
  	end
  end
end
