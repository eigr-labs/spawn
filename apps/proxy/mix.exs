defmodule Proxy.MixProject do
  use Mix.Project

  def project do
    [
      app: :proxy,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Proxy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:actors, "~> 0.1", in_umbrella: true},
      {:bakeware, "~> 0.2"},
      {:bandit, "~> 0.5"},
      {:observer_cli, "~> 1.7"},
      {:prometheus, "~> 4.8"},
      {:prometheus_plugs, "~> 1.1"}
    ]
  end
end
