defmodule SpawnMonitor.Utils do
  @moduledoc false

  def env(key, default) when is_binary(key), do: System.get_env(key, default)

  def to_bool("false"), do: false
  def to_bool("true"), do: true
  def to_bool(_), do: false
end
