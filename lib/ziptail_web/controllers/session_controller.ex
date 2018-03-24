defmodule ZiptailWeb.SessionController do
	use ZiptailWeb, :controller
	alias Ziptail.Account
	alias Ziptail.Mailer
	alias ZiptailWeb.Email


	def new(conn, _) do
		render(conn, "new.html")
	end

	def send_link(conn, %{"session" => %{"email" => email}}) do
		case Account.get_user_by_email(email) do
			:nil ->
				conn
				|> put_flash(:error, "Invalid email")
				|> render("new.html")
			user ->
				# Create a token
				token = Account.generate_token(user)
				link = session_url(conn, :create, token)
				IO.puts("+++++++++++++++++++++++")
        IO.puts(link)
        IO.puts("+++++++++++++++++++++++")

        Email.admin_email(email, link)
        |> Mailer.deliver_later
        
				conn
				|> put_flash(:info, "We sent you an email link. Please check your email.")
				|> render(:new)
		end
	end

	def create(conn, %{"token" => token}) do
		case Account.verify_token(token) do
			{:ok, user_id} ->
				user = Account.get_user(user_id)
				conn
				|> assign(:current_user, user)
				|> put_session(:user_id, user.id)
				|> configure_session(renew: true)
				|> put_flash(:info, "Login Successful")
				|> redirect(to: page_path(conn, :index))
			{:error, :invalid} ->
        conn
        |> put_flash(:error, "Invalid Link, Can't Log in")
        |> render("new.html")
      {:error, :expired} ->
        conn
        |> put_flash(:error, "Links has been expired. Please do it again")
        |> render("new.html")
		end
		
	end

	def delete(conn, _) do
		clear_session(conn)
		|> put_flash(:info, "You have been logged out")
		|> redirect(to: page_path(conn, :index))
	end
end