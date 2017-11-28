defmodule ZiptailWeb.PageController do
  use ZiptailWeb, :controller
  alias Ziptail.Mailer
  alias ZiptailWeb.Email

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"subscribe" => %{"email" => email, "phone" => phone}}) do
  	Email.subscription_email(email, phone)
  	|> Mailer.deliver_later
  	conn
  	|> put_flash(:info, "Thanks for subscription")
  	|> render(:index)
  end
end
