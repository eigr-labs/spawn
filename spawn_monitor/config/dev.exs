import Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :spawn_monitor, SpawnMonitorWeb.Endpoint,
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  secret_key_base: "1lFra0dpD7ayAn4I3NANdZTKZyd2ecunwvTQzKw+dIBsDZElo3i4cvRLhee3F/VL",
  watchers: []

config :spawn_monitor, :cookie, :my_cookie

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
