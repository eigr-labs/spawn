defmodule Spawn.Cluster.Node.Registry do
  @moduledoc """
  Defines a distributed registry for all process
  """
  use Horde.Registry

  def child_spec() do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [%{}]}
    }
  end

  @doc false
  def start_link(_) do
    Horde.Registry.start_link(__MODULE__, [keys: :unique, members: :auto], name: __MODULE__)
  end

  @impl true
  def init(args) do
    Horde.Registry.init(args)
  end

  @doc """
  Get Process if this is alive.
  """
  def lookup(mod, actor_name) do
    Horde.Registry.lookup(__MODULE__, {mod, actor_name})
  end

  @doc """
  Check if Process is alive.
  """
  def isAlive(mod, actor_name) do
    case Horde.Registry.lookup(__MODULE__, {mod, actor_name}) do
      [] -> false
      _ -> true
    end
  end

  @doc """
  List all alive PIDs from given registry module.
  """
  @spec list_actor_pids(module()) :: list(pid())
  def list_actor_pids(mod) do
    Horde.Registry.select(__MODULE__, [{{:"$1", :_, :_}, [], [:"$1"]}])
    |> Stream.filter(fn {mod_name, _} -> mod_name == mod end)
    |> Stream.map(&Horde.Registry.match(__MODULE__, &1, :_))
    |> Stream.scan([], fn [{pid, _}], acc -> [pid | acc] end)
    |> Stream.flat_map(& &1)
    # This is a HUUUUGE work around MIAUUUU
    |> Stream.uniq()
    # |> Stream.filter(&Process.alive?/1)
    |> Enum.to_list()
  end
end
