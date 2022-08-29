defmodule Actors.Node.Client do
  use Tesla

  alias Actors.Config.Vapor, as: Config

  @actor_invoke_uri "/api/v1/actors/actions"

  adapter(Tesla.Adapter.Finch, name: SpawnHTTPClient)

  plug(
    Tesla.Middleware.BaseUrl,
    "http://#{Config.get(Actors, :user_function_host)}:#{Config.get(Actors, :user_function_port)}"
  )

  plug(Tesla.Middleware.Headers, [{"content-type", "application/octet-stream"}])
  plug(Tesla.Middleware.Logger)

  def invoke_host_actor(req) do
    post(@actor_invoke_uri, req)
  end
end
