defmodule ZiptailWeb.Email do
	use Bamboo.Phoenix, view: ZiptailWeb.EmailView

	# Email Subscription...(email and phone number)
	def subscription_email(email, phone) do
		generate_email()
		|> subject("Customer Subscribed")
		|> assign(:email, email)
		|> assign(:phone, phone)
		|> render(:subscription)
	end
	# Contact Page (name, email, message)
	def contact_email(name, email, message) do
		generate_email()
		|> subject("Customer contact us")
		|> assign(:name, name)
		|> assign(:email, email)
		|> assign(:message, message)
		|> render(:contact)
	end
	# FriendChise Page
	def friendchise_email(firstname, lastname, address, city, state, zipcode, phone, email, message) do
		generate_email()
		|> subject("Friendchise Request Email")
		|> assign(:firstname, firstname)
		|> assign(:lastname, lastname)
		|> assign(:address, address)
		|> assign(:city, city)
		|> assign(:state, state)
		|> assign(:zipcode, zipcode)
		|> assign(:phone, phone)
		|> assign(:email, email)
		|> assign(:message, message)
		|> render(:friendchise)
	end

	# Admin login
	def admin_email(email, link) do
		new_email()
		|> subject("Ziptail Admin Login Link")
		|> to(email)
		|> from("info@goziptail.com")
		|> put_html_layout({ZiptailWeb.LayoutView, "email.html"})
		|> assign(:link, link)
		|> render(:admin)
	end

	defp generate_email() do
		new_email()
		|> to("info@goziptail.com")
		|> from("info@goziptail.com")
		|> put_html_layout({ZiptailWeb.LayoutView, "email.html"})
	end
end