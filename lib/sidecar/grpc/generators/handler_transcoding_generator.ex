defmodule Sidecar.GRPC.Generators.HandlerTranscodingGenerator do
  @moduledoc """
  Module for generating an actor dispatcher with transcoding capabilities for gRPC methods.

  This module implements the `ProtobufGenerate.Plugin` behaviour to generate an actor dispatcher
  with transcoding capabilities for each gRPC method defined in the Protobuf service.

  """
  @behaviour ProtobufGenerate.Plugin

  alias Actors.Config.PersistentTermConfig, as: Config
  alias Protobuf.Protoc.Generator.Util

  @impl true
  def template do
    """
    <%= if @render do %>
    defmodule <%= @module %>.ActorDispatcher do
      use GRPC.Server, service: <%= @service_name %>.Service, http_transcode: true

      alias Sidecar.GRPC.Dispatcher

      <%= for {method_name, input, output, _options} <- @methods do %>
        @spec <%= Macro.underscore(method_name) %>(<%= input %>.t(), GRPC.Server.Stream.t()) :: <%= output %>.t()
        def <%= Macro.underscore(method_name) %>(message, stream) do
          request = %{
            system: <%= inspect(@actor_system) %>,
            actor_name: <%= inspect(@actor_name) %>,
            action_name: <%= inspect(method_name) %>,
            input: message,
            stream: stream,
            descriptor: <%= @service_name %>.Service.descriptor()
          }

          Dispatcher.dispatch(request)
        end
      <% end %>
    end
    <% end %>
    """
  end

  @impl true
  def generate(ctx, %Google.Protobuf.FileDescriptorProto{service: [_ | _] = svcs} = _desc) do
    for svc <- svcs do
      mod_name = Util.mod_name(ctx, [Macro.camelize(svc.name)])
      actor_name = Macro.camelize(svc.name)
      actor_system = Config.get(:actor_system_name)

      methods =
        for m <- svc.method do
          input = service_arg(Util.type_from_type_name(ctx, m.input_type), m.client_streaming)
          output = service_arg(Util.type_from_type_name(ctx, m.output_type), m.server_streaming)

          options =
            m.options
            |> opts()
            |> inspect(limit: :infinity)

          {m.name, input, output, options}
        end

      {mod_name,
       [
         render: true,
         module: mod_name,
         actor_system: actor_system,
         actor_name: actor_name,
         service_name: mod_name,
         methods: methods,
         version: Util.version()
       ]}
    end
  end

  def generate(_ctx, _opts), do: {"unknown", [render: false]}

  defp service_arg(type, _streaming? = true), do: "stream(#{type})"
  defp service_arg(type, _streaming?), do: type

  defp opts(nil), do: %{}

  defp opts(%Google.Protobuf.MethodOptions{__pb_extensions__: extensions})
       when extensions == %{} do
    %{}
  end

  defp opts(%Google.Protobuf.MethodOptions{__pb_extensions__: extensions}) do
    for {{type, field}, value} <- extensions, into: %{} do
      {field, %{type: type, value: value}}
    end
  end
end
