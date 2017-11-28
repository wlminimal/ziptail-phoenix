defmodule ZiptailWeb.FriendchiseController do
	use ZiptailWeb, :controller
	alias Ziptail.Mailer
	alias ZiptailWeb.Email

	def show(conn, _) do
		render(conn, "show.html")
	end

	def create(conn, %{"friendchise" => %{"first_name" => first_name, "last_name" => last_name, "address" => address, "city" => city, "state" => state, "zipcode" => zipcode, "phone" => phone, "email" => email, "message" => message}}) do
		Email.friendchise_email(
			first_name,
			last_name,
			address,
			city,
			state,
			zipcode,
			phone,
			email,
			message
			)
		|> Mailer.deliver_later
		conn
		|> put_flash(:info, "Thanks for your interest, We will get back to you soon")
		|> render(:show)
	end
end