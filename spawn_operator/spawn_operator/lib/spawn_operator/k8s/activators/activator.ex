defmodule SpawnOperator.K8s.Activators.Activator do
  @moduledoc false
  alias SpawnOperator.K8s.Activators.{Simple, Rabbitmq}

  import Spawn.Utils.Common, only: [to_existing_atom_or_new: 1]

  @spec apply(map(), Bonny.Axn.t(), atom()) :: Bonny.Axn.t()
  def apply(args, axn, action) do
    case get_activator_type(args.params) do
      :simple ->
        Simple.apply(args, axn, action)

      :amqp ->
        Rabbitmq.apply(args, axn, action)

      _ ->
        raise ArgumentError, "Invalid Activator Type"
    end
  end

  defp get_activator_type(params) do
    String.downcase(params.activator.type)
    |> to_existing_atom_or_new()
  end
end
