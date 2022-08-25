import Config

# config :statestores, Statestores.Vault,
# json_library: Jason,
# ciphers: [
#  default:
#    {Cloak.Ciphers.AES.GCM,
#     tag: "AES.GCM.V1",
#     key: Base.decode64!("3Jnb0hZiHIzHTOih7t2cTEPEpY98Tu1wvQkPfq/XwqE="),
#     iv_length: 12},
#  secondary:
#    {Cloak.Ciphers.AES.CTR,
#     tag: "AES.CTR.V1", key: Base.decode64!("o5IzV8xlunc0m0/8HNHzh+3MCBBvYZa0mv4CsZic5qI=")}
#  ]

config :statestores,
  ecto_repos: [Statestores.Adapters.MySQL, Statestores.Adapters.Postgres]

config :statestores, Statestores.Adapters.MySQL,
  database: "statestores_my_sql",
  username: "user",
  password: "pass",
  hostname: "localhost"

config :statestores, Statestores.Adapters.Postgres,
  database: "statestores_postgres",
  username: "user",
  password: "pass",
  hostname: "localhost"

config :logger,
  backends: [:console],
  truncate: 65536

# ,
# compile_time_purge_matching: [
#  [level_lower_than: :debug]
# ]

# Our Console Backend-specific configuration
config :logger, :console,
  format: "$date $time [$node]:[$metadata]:[$level]:$levelpad$message\n",
  metadata: [:pid]

config :protobuf, extensions: :enabled

config :prometheus, MetricsEndpoint.Exporter,
  path: "/metrics",
  format: :auto,
  registry: :default,
  auth: false

# App Configuration
config :proxy,
  http_port: System.get_env("PROXY_HTTP_PORT", "9001") |> String.to_integer()

import_config "#{config_env()}.exs"
