defmodule SpawnMonitor.Cluster do
  @moduledoc false
  require Logger

  import SpawnMonitor.Utils

  def get_spec() do
    cluster_strategy = env("PROXY_CLUSTER_STRATEGY", "gossip")

    topologies =
      case cluster_strategy do
        "epmd" ->
          get_epmd_strategy()

        "gossip" ->
          get_gossip_strategy()

        "kubernetes-dns" ->
          get_k8s_dns_strategy()

        _ ->
          Logger.warning("Invalid Topology")
      end

    if topologies && Code.ensure_compiled(Cluster.Supervisor) do
      Logger.debug("Cluster topology #{inspect(topologies)}")

      {Cluster.Supervisor,
       [
         topologies,
         [name: String.to_atom("#{__MODULE__}.Cluster")]
       ]}
    end
  end

  defp get_epmd_strategy() do
    [
      proxy: [
        strategy: Cluster.Strategy.Epmd
      ]
    ]
  end

  defp get_gossip_strategy() do
    reuseaddr =
      env("PROXY_CLUSTER_GOSSIP_REUSE_ADDRESS", "true")
      |> to_bool()

    broadcast_only =
      env("PROXY_CLUSTER_GOSSIP_BROADCAST_ONLY", "true")
      |> to_bool()

    [
      proxy: [
        strategy: Cluster.Strategy.Gossip,
        config: [
          reuseaddr: reuseaddr,
          multicast_addr: env("PROXY_CLUSTER_GOSSIP_MULTICAST_ADDRESS", "255.255.255.255"),
          broadcast_only: broadcast_only
        ]
      ]
    ]
  end

  defp get_k8s_dns_strategy() do
    polling_interval =
      env("PROXY_CLUSTER_POLLING", "3000")
      |> String.to_integer()

    [
      proxy: [
        strategy: Cluster.Strategy.Kubernetes.DNS,
        config: [
          service: env("PROXY_HEADLESS_SERVICE", "proxy-headless"),
          application_name: "proxy",
          polling_interval: polling_interval
        ]
      ]
    ]
  end
end
