defmodule SpawnMonitorWeb.Router do
  @moduledoc false
  use SpawnMonitorWeb, :router
  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through([:fetch_session, :protect_from_forgery])

    get("/health", SpawnMonitorWeb.HealthController, :index)

    live_dashboard("/",
      metrics: false,
      request_logger: false,
      additional_pages: [broadway: BroadwayDashboard]
    )
  end
end
