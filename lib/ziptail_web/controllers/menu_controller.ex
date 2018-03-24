defmodule ZiptailWeb.MenuController do
	use ZiptailWeb, :controller

	def show(conn, _) do
		render(conn, "show.html")
	end
end