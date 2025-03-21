import Config

config :sloow, Sloow.Repo,
  username: "postgres",
  password: "6ZxVM9ztk96wmcuQQRZ6",
  hostname: "db",
  database: "files_sloow_de",
  stacktrace: false,
  show_sensitive_data_on_connection_error: false,
  pool_size: 10

# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix assets.deploy` task,
# which you should run after static files are built and
# before starting your production server.

config :sloow, SloowWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  url: [host: "localhost"],
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Sloow.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
