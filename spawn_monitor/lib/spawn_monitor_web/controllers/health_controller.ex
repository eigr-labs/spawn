defmodule SpawnMonitorWeb.HealthController do
  @moduledoc false
  use SpawnMonitorWeb, :controller

  def index(conn, _) do
    version = Application.spec(:spawn_monitor, :vsn) |> List.to_string()

    json(conn, %{
      "application" => "spawn_monitor",
      "version" => version
    })
  end
end
