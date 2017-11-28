# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ziptail,
  ecto_repos: [Ziptail.Repo]

# Configures the endpoint
config :ziptail, ZiptailWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "viajnILojBphciwMac0ffZQMxbSPopfzJfDfJapKpC0p7YVfrovxDG6cMxH6YI1y",
  render_errors: [view: ZiptailWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ziptail.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


# Bamboo
# config :ziptail, Ziptail.Mailer,
#   adapter: Bamboo.LocalAdapter

# Bamboo
config :ziptail, Ziptail.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.zoho.com",
  hostname: "goziptail.com",
  port: 465,
  username: System.get_env("ZOHO_MAIL"), # or {:system, "SMTP_USERNAME"}
  password: System.get_env("ZOHO_PASS"), # or {:system, "SMTP_PASSWORD"}
  tls: :if_available, # can be `:always` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: true, # can be `true`s
  retries: 1

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure thesis content editor
config :thesis,
  store: Thesis.EctoStore,
  authorization: Ziptail.ThesisAuth,
  uploader: Thesis.RepoUploader
  #  uploader: <MyApp>.<CustomUploaderModule>
  #  uploader: Thesis.OspryUploader
config :thesis, Thesis.EctoStore, repo: Ziptail.Repo
# config :thesis, Thesis.OspryUploader,
#   ospry_public_key: "pk-prod-asdfasdfasdfasdf"
# If you want to allow creating dynamic pages:
# config :thesis, :dynamic_pages,
#   view: Ziptail.PageView,
#   templates: ["index.html", "otherview.html"],
#   not_found_view: Ziptail.ErrorView,
#   not_found_template: "404.html"
