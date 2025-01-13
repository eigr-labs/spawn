defmodule StatestoresMysql.MixProject do
  use Mix.Project

  @app :spawn_statestores_mariadb
  @version "0.0.0-local.dev"
  @source_url "https://github.com/eigr/spawn/blob/main/spawn_statestores/statestores_mariadb"

  def project do
    [
      app: @app,
      version: @version,
      description: "Spawn Statestores Mysql is a storage lib for the Spawn Actors System",
      source_url: @source_url,
      homepage_url: "https://eigr.io/",
      build_path: "./_build",
      config_path: "../../config/config.exs",
      deps_path: "./deps",
      lockfile: "./mix.lock",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      licenses: ["Apache-2.0"],
      links: %{GitHub: @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatter_opts: [gfm: true],
      extras: [
        "README.md"
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cloak_ecto, "~> 1.2"},
      {:ecto_sql, "~> 3.12"},
      {:ecto_mysql_extras, "~> 0.6.3"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:myxql, "~> 0.6"},
      {:spawn_statestores, path: "../statestores"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
