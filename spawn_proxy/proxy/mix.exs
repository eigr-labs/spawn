defmodule Proxy.MixProject do
  use Mix.Project

  @app :proxy
  @version "2.0.0-RC1"

  def project do
    [
      app: @app,
      version: @version,
      build_path: "../../_build",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        :runtime_tools,
        :os_mon
      ],
      mod: {Proxy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:spawn, "2.0.0-RC1"},
      {:spawn_statestores_mariadb, "2.0.0-RC1", optional: true},
      {:spawn_statestores_postgres, "2.0.0-RC1", optional: true},
      {:spawn_statestores_native, "2.0.0-RC1", optional: true},
      {:bakeware, "~> 0.2"},
      {:bandit, "~> 1.5"},
      {:observer_cli, "~> 1.7"},
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: false}
    ]
  end

  defp releases do
    [
      proxy: [
        include_executables_for: [:unix],
        applications: [
          opentelemetry_exporter: :permanent,
          opentelemetry: :temporary,
          proxy: :permanent
        ],
        steps: [
          :assemble,
          &Bakeware.assemble/1
        ],
        bakeware: [compression_level: 19]
      ]
    ]
  end
end
