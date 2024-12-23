defmodule Sidecar.GRPC.Generators.ActorInvoker do
  @moduledoc """
  Module for generating an actor invoker helper.
  """
  @behaviour ProtobufGenerate.Plugin

  alias Actors.Config.PersistentTermConfig, as: Config
  alias Protobuf.Protoc.Generator.Util

  @impl true
  def template do
    """
    defmodule <%= @module %> do
      @moduledoc "This module provides helper functions for invoking the methods on the <%= @service_name %> actor."

      <%= for {method_name, input, output, _options} <- @methods do %>
        @doc \"\"\"
        Invokes the <%= method_name %> method registered on <%= @actor_name %>.

        ## Parameters
        - `payload` - The payload to send to the action.
        - `opts` - The options to pass to the action.

        ## Examples
        ```elixir
        iex> <%= @module %>.<%= Macro.underscore(method_name) %>(%<%= input %>{}, async: false, metadata: %{"example" => "metadata"})
        {:ok, %<%= output %>{}}
        ```
        \"\"\"
        @spec <%= Macro.underscore(method_name) %>(<%= input %>.t(), Keyword.t()) :: {:ok, <%= output %>.t()} | {:error, term()} | {:ok, :async}
        def <%= Macro.underscore(method_name) %>(%<%= input %>{} = payload \\\\ nil, opts \\\\ []) do
          opts = [
            system: opts[:system] || "<%= @actor_system %>",
            action: "<%= method_name %>",
            payload: payload,
            async: opts[:async] || false,
            metadata: opts[:metadata] || %{}
          ]

          actor_to_invoke = opts[:actor] || "<%= @actor_name %>"

          opts = if actor_to_invoke == "<%= @actor_name %>" do
            opts
          else
            Keyword.put(opts, :ref, "<%= @actor_name %>")
          end

          SpawnSdk.invoke(opts[:id] || "<%= @actor_name %>", opts)
        end
      <% end %>
    end
    """
  end

  @impl true
  def generate(ctx, %Google.Protobuf.FileDescriptorProto{service: svcs} = _desc) do
    for svc <- svcs do
      mod_name = Util.mod_name(ctx, [Macro.camelize(svc.name)])
      actor_name = Macro.camelize(svc.name)
      actor_system = Config.get(:actor_system_name)

      methods =
        for m <- svc.method do
          input = Util.type_from_type_name(ctx, m.input_type)
          output = Util.type_from_type_name(ctx, m.output_type)

          options =
            m.options
            |> opts()
            |> inspect(limit: :infinity)

          {m.name, input, output, options}
        end

      {mod_name,
       [
         module: mod_name,
         actor_system: actor_system,
         actor_name: actor_name,
         service_name: mod_name,
         methods: methods,
         version: Util.version()
       ]}
    end
  end

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
