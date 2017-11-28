defmodule ZiptailWeb.Router do
  use ZiptailWeb, :router
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ZiptailWeb.Plugs.LoadUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ZiptailWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/", PageController, :create

    get "/admin", SessionController, :new
    post "/admin", SessionController, :send_link
    get "/admin/:token", SessionController, :create

    get "/logout", SessionController, :delete
    get "/menu", MenuController, :show
    get "/contact", ContactController, :show
    post "/contact", ContactController, :create
    get "/friendchise", FriendchiseController, :show
    post "/friendchise", FriendchiseController, :create
  end

  # For Email Preview 
  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end
  # Other scopes may use custom stacks.
  # scope "/api", ZiptailWeb do
  #   pipe_through :api
  # end
end
