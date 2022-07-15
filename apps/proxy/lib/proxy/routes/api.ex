defmodule Proxy.Routes.API do
  use Proxy.Routes.Base
  require Logger

  alias Eigr.Functions.Protocol.{
    ActorInvocationResponse,
    InvocationRequest,
    InvocationResponse,
    RegistrationRequest,
    RegistrationResponse,
    RequestStatus
  }

  @content_type "application/octet-stream"

  post "/system" do
    with registration_payload <- get_body(conn.body_params, RegistrationRequest),
         {:ok, response} <- Actors.register(registration_payload) do
      send!(conn, 200, encode(RegistrationResponse, response), @content_type)
    else
      _ ->
        status = RequestStatus.new(status: :ERROR, message: "Error on create Actors")
        response = RegistrationResponse.new(status: status)
        send!(conn, 500, encode(RegistrationResponse, response), @content_type)
    end
  end

  get "/system/:name/actors/:actor_name" do
    Actors.get_state(name, actor_name)
  end

  post "/system/:name/actors/:actor_name/invoke" do
    with %InvocationRequest{actor_id: actor} = request <-
           get_body(conn.body_params, InvocationRequest),
         {:ok, %ActorInvocationResponse{value: value} = _response} <- Actors.invoke(request) do
      send!(
        conn,
        200,
        encode(
          InvocationResponse,
          InvocationResponse.new(
            actor_id: actor,
            value: value,
            status: RequestStatus.new(status: :OK)
          )
        ),
        @content_type
      )
    else
      _ ->
        status = RequestStatus.new(status: :ERROR, message: "Error on invoke Actor")
        response = InvocationResponse.new(status: status)
        send!(conn, 500, encode(InvocationResponse, response), @content_type)
    end
  end

  defp get_body(%{"_proto" => body}, type), do: type.decode(body)
  defp get_body(body, _type), do: body

  defp encode(module, payload), do: module.encode(payload)
end
