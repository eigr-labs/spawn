defmodule StatestoresSqlite.MixProject do
  use Mix.Project

  @app :spawn_statestores_sqlite
  @version "0.1.0"
  @source_url "https://github.com/eigr/spawn/blob/main/spawn_statestores/statestores_sqlite"

  def project do
    [
      app: @app,
      version: @version,
      description: "Spawn Statestores Sqlite3 is a storage lib for the Spawn Actors System",
      source_url: @source_url,
      homepage_url: "https://eigr.io/",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.14",
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
      files: ["lib", "mix.exs", "priv", "README.md", "LICENSE"],
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
      {:vapor, "~> 0.10"},
      {:cloak_ecto, "~> 1.2"},
      {:ecto_sql, "~> 3.8"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:ecto_sqlite3, "~> 0.8.2"}
    ] ++ deps_for_release()
  end

  @is_release System.get_env("RELEASE")
  defp deps_for_release do
    if @is_release do
      [{:spawn_statestores, "~> 0.1.0"}]
    else
      [{:spawn_statestores, path: "../statestores"}]
    end
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end