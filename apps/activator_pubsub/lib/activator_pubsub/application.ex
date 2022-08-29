defmodule ActivatorPubSub.Application do
  @moduledoc false

  use Application

  alias Actors.Config.Vapor, as: Config
  import Activator, only: [get_http_port: 1]

  @impl true
  def start(_type, _args) do
    config = Config.load(__MODULE__)

    MetricsEndpoint.Exporter.setup()
    MetricsEndpoint.PrometheusPipeline.setup()

    children =
      [
        Spawn.Cluster.Supervisor.child_spec(config),
        {Bandit,
         plug: ActivatorPubSub.Router, scheme: :http, options: [port: get_http_port(config)]}
      ] ++
        if Mix.env() == :test,
          do: [],
          else: [Actors.Supervisors.EntitySupervisor.child_spec(config)]

    opts = [strategy: :one_for_one, name: ActivatorPubSub.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
