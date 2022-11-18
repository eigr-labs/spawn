defmodule Operator.MixProject do
  use Mix.Project

  @app :spawn_operator
  @version "0.0.0-local.dev"

  def project do
    [
      app: @app,
      version: @version,
      build_path: "../../_build",
      config_path: "config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SpawnOperator.Application, [env: Mix.env()]}
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 0.5"},
      {:burrito, github: "burrito-elixir/burrito"},
      {:bonny, "~> 1.0.0-rc.1"},
      {:spawn, path: "../../"}
    ]
  end

  defp releases do
    [
      spawn_operator: [
        include_executables_for: [:unix],
        applications: [spawn_operator: :permanent],
        steps: [
          :assemble,
          &Burrito.wrap/1
        ],
        burrito: [
          targets: [
            linux: [os: :linux, cpu: :x86_64],
            linux_musl: [
              os: :linux,
              cpu: :x86_64,
              libc: :musl
            ]
          ]
        ]
      ]
    ]
  end
end
