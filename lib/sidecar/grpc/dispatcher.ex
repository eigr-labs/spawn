defmodule Sidecar.GRPC.Dispatcher do
  @moduledoc """
  Module for dispatching gRPC messages to Actors.

  This module handles the dispatching of gRPC messages to Actors based on the provided parameters.
  It logs relevant information and raises an error if the service descriptor is not found.

  """
  require Logger

  alias GRPC.Server
  alias Sidecar.GRPC.ServiceResolver, as: ActorResolver

  @doc """
    Dispatches a gRPC message to the specified actor.

    ### Parameters:

    - `request` - A map containing the following parameters:
      - `system: system_name` - The name of the actor system.
      - `actor_name: actor_name` - The name of the actor.
      - `action_name: action_name` - The name of action to call.
      - `input: message` - The input message.
      - `stream: stream` - The stream (optional).
      - `descriptor: descriptor` - The service descriptor.

    ### Example:

    ```elixir
    request = %{
      system: "spawn-system",
      actor_name: "GreeterActor",
      action_name: "SayHello",
      input: %{data: "some_data"},
      stream: %GRPC.Server.Stream{},
        descriptor: %Google.Protobuf.FileDescriptorProto{
          name: "helloworld.proto",
          package: "helloworld"},
          service: [
            %Google.Protobuf.ServiceDescriptorProto{
              name: "GreeterService",
              method: [
                %Google.Protobuf.MethodDescriptorProto{
                  name: "SayHello",
                  input_type: ".helloworld.HelloRequest",
                  output_type: ".helloworld.HelloReply",
                }
              ]
            }
          ]
        }
    }

    Sidecar.GRPC.Dispatcher.dispatch(request)

  """
  def dispatch(
        %{
          system: system_name,
          actor_name: actor_name,
          descriptor: descriptor
        } = _request
      )
      when is_nil(descriptor) do
    Logger.error(
      "Service descriptor not found. Impossible to call Actor #{system_name}:#{actor_name}"
    )

    raise GRPC.RPCError,
      status: GRPC.Status.failed_precondition(),
      message:
        "Service descriptor not found. Impossible to call Actor #{system_name}:#{actor_name}"
  end

  def dispatch(
        %{
          system: system_name,
          actor_name: actor_name,
          action_name: action_name,
          input: message,
          stream: stream,
          descriptor: descriptor
        } = request
      ) do
    Logger.debug(
      "Dispatching gRPC message to Actor #{system_name}:#{actor_name}. Params: #{inspect(request)}"
    )

    # TODO
    # Before forwading the request, we must find out through the ServiceResolver module what type of RPC
    # it is (unary, client streaming, server streaming, etc...). This way we will know how to forward
    # the request correctly (synchronously or asynchronously), as well as how to properly handle the GRPC response.
  end
end
