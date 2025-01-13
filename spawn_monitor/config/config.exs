import Config

config :spawn_monitor,
  halt_on_abort: true,
  namespace: SpawnMonitor

# Configures the endpoint
config :spawn_monitor, SpawnMonitorWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SpawnMonitorWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SpawnMonitor.PubSub,
  live_view: [signing_salt: "kA47bW1N"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
