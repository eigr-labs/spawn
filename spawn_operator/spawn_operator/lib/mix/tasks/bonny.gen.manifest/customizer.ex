defmodule Mix.Tasks.Bonny.Gen.Manifest.SpawnOperatorCustomizer do
  @moduledoc """
  Implements a callback to override manifests generated by `mix bonny.gen.manifest`
  """

  @doc """
  This function is called for every resource generated by `mix bonny.gen.manifest`.
  Use pattern matching to override specific resources.

  Be careful in your pattern matching. Sometimes the map keys are strings,
  sometimes they are atoms.

  ### Examples

  def override(%{kind: "ServiceAccount"} = resource) do
    put_in(resource, ~w(metadata labels foo)a, "bar")
  end

  If kind is equal to Deployment then this function generated Deployment manifest like bellow:

  ```yaml
  %{
    apiVersion: "apps/v1",
    kind: "Deployment",
    metadata: %{
      labels: %{"k8s-app" => "spawn-operator"},
      name: "spawn-operator",
      namespace: "default"
    },
    spec: %{
      replicas: 1,
      selector: %{matchLabels: %{"k8s-app" => "spawn-operator"}},
      template: %{
        metadata: %{labels: %{"k8s-app" => "spawn-operator"}},
        spec: %{
          containers: [
            %{
              env: [
                %{name: "MIX_ENV", value: "prod"},
                %{
                  name: "BONNY_POD_NAME",
                  valueFrom: %{fieldRef: %{fieldPath: "metadata.name"}}
                },
                %{
                  name: "BONNY_POD_NAMESPACE",
                  valueFrom: %{fieldRef: %{fieldPath: "metadata.namespace"}}
                },
                %{
                  name: "BONNY_POD_IP",
                  valueFrom: %{fieldRef: %{fieldPath: "status.podIP"}}
                },
                %{
                  name: "BONNY_POD_SERVICE_ACCOUNT",
                  valueFrom: %{fieldRef: %{fieldPath: "spec.serviceAccountName"}}
                }
              ],
              image: "eigr/spawn-operator:1.0.0-rc16",
              name: "spawn-operator",
              resources: %{
                limits: %{cpu: "200m", memory: "200Mi"},
                requests: %{cpu: "200m", memory: "200Mi"}
              },
              securityContext: %{
                allowPrivilegeEscalation: false,
                readOnlyRootFilesystem: true,
                runAsNonRoot: true,
                runAsUser: 65534
              },
              volumeMounts: [
                %{
                  "mountPath" => "/app/.cache/bakeware/",
                  "name" => "bakeware-cache"
                }
              ]
            }
          ],
          serviceAccountName: "spawn-operator",
          volumes: [%{"emptyDir" => %{}, "name" => "bakeware-cache"}]
        }
      }
    }
  """

  @spec override(Bonny.Resource.t()) :: Bonny.Resource.t()
  def override(%{kind: "Deployment"} = resource) do
    %{resource | spec: %{resource.spec | template: update_template(resource)}}
  end

  # fallback
  def override(resource), do: resource

  defp update_template(resource) do
    spec = resource.spec.template.spec
    container = List.first(resource.spec.template.spec.containers)

    updated_spec =
      Map.put(spec, :volumes, [
        %{"name" => "bakeware-cache", "emptyDir" => %{}}
      ])

    updated_container =
      Map.put(container, :volumeMounts, [
        %{"mountPath" => "/app/.cache/bakeware/", "name" => "bakeware-cache"}
      ])

    updated_spec = %{
      updated_spec
      | containers: [updated_container]
    }

    %{
      resource.spec.template
      | spec: updated_spec
    }
  end
end
