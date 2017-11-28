defmodule ZiptailWeb.ContactController do
	use ZiptailWeb, :controller
	alias Ziptail.Mailer
	alias ZiptailWeb.Email

	def show(conn, _) do
		render(conn, "show.html")
	end

	def create(conn, %{"contact" => %{"name" => name, "email" => email, "message" => message}}) do
		Email.contact_email(name, email, message)
		|> Mailer.deliver_later
		
		conn
		|> put_flash(:info, "Thanks for contacting us, We will get back to you soon")
		|> render(:show)
	end
end