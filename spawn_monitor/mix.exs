defmodule SpawnMonitor.MixProject do
  use Mix.Project

  @app :spawn_monitor
  @version "0.0.0-local.dev"
  @description "Spawn Monitor application using Phoenix LiveDashboard"

  def project do
    [
      app: @app,
      version: @version,
      build_path: "_build",
      config_path: "config/config.exs",
      deps_path: "deps",
      lockfile: "mix.lock",
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :runtime_tools, :os_mon, :inets],
      mod: {SpawnMonitor.Application, []}
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.7"},
      {:phoenix_view, "~> 2.0"},
      {:phoenix_live_dashboard, "~> 0.8", phoenix_live_dashboard_opts()},
      {:ecto_psql_extras, "~> 0.7"},
      {:broadway_dashboard, "~> 0.4"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:libcluster, "~> 3.3"},
      {:ex_doc, "~> 0.25", only: :dev}
    ]
  end

  defp releases do
    [
      spawn_monitor: [
        include_executables_for: [:unix],
        applications: [spawn_monitor: :permanent],
        steps: [
          :assemble,
          &Bakeware.assemble/1
        ],
        bakeware: [compression_level: 19]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp phoenix_live_dashboard_opts do
    if path = System.get_env("LIVE_DASHBOARD_PATH") do
      [path: path, override: true]
    else
      []
    end
  end
end
