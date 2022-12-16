defmodule SpawnOperator.K8s.HeadlessService do
  @moduledoc false

  @behaviour SpawnOperator.K8s.Manifest

  @ports [
    %{"name" => "epmd", "protocol" => "TCP", "port" => 4369, "targetPort" => "epmd"}
  ]

  @impl true
  def manifest(
        %{
          system: system,
          namespace: ns,
          name: _name,
          params: _params,
          labels: _labels,
          annotations: _annotations
        } = _resource,
        _opts \\ []
      ),
      do: %{
        "apiVersion" => "v1",
        "kind" => "Service",
        "metadata" => %{
          "labels" => %{
            "svc-cluster-name" => "system-#{system}-svc",
            "spawn-eigr.io/controller.version" =>
              "#{to_string(Application.spec(:spawn_operator, :vsn))}"
          },
          "name" => "system-#{system}-svc",
          "namespace" => ns
        },
        "spec" => %{
          "clusterIP" => "None",
          "selector" => %{"actor-system" => system},
          "ports" => @ports
        }
      }
end
