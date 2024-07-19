defmodule SpawnCtl.Commands.Install do
  @moduledoc falses
  use DoIt.Command,
    name: "install",
    description: "Install orchestrators runtime like Kubernetes or others."

  subcommand(SpawnCtl.Commands.Install.Kubernetes)
end
