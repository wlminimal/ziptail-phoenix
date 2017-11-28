defmodule Ziptail.Account do
	alias Ziptail.Account.User
	alias Ziptail.Repo
	import Ecto.Query

	def build_user(attrs \\ %{}) do
		%User{}
		|> User.changeset(attrs)
	end

	def create_user(attrs) do
		attrs
		|> build_user()
		|> Repo.insert()
	end

	def get_user_by_email(email) do
		Repo.one(from u in User, where: u.email == ^email)
	end

	def get_user_by_credentials(%{"email" => email, "password" => password}) do
		user = get_user_by_email(email)

		cond do
			user && Comeonin.Bcrypt.checkpw(password, user.password_hash) ->
				user
			true ->
				:error
		end
	end

	def get_user(id), do: Repo.get(User, id)	

	def generate_token(user) do
		token = Phoenix.Token.sign(ZiptailWeb.Endpoint, "ziptailadminuser", user.id )
	end

	@max_age 600 # 10 min
	def verify_token(token) do
		Phoenix.Token.verify(ZiptailWeb.Endpoint, "ziptailadminuser", token, max_age: @max_age)
	end
end