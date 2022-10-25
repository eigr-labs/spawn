defmodule Statestores.Supervisor do
  @moduledoc false
  use Supervisor

  import Statestores.Util, only: [load_repo: 0]

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def child_spec() do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [[]]}
    }
  end

  @impl true
  def init(_args) do
    repo = load_repo()
    Statestores.Config.load()
    Statestores.Migrator.migrate(repo)

    children = [
      Statestores.Vault,
      repo
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
