defmodule SpawnMonitor.Application do
  @moduledoc false
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      SpawnMonitor.Cluster.get_spec(),
      {Phoenix.PubSub, name: SpawnMonitor.PubSub},
      SpawnMonitorWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: SpawnMonitor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    SpawnMonitorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
