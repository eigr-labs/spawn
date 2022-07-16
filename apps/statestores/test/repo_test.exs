defmodule StatestoresTest.RepoTest do
  use ExUnit.Case
  alias Statestores.Schemas.Event
  import Statestores.Util, only: [load_repo: 0]

  setup do
    repo = load_repo()

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(repo)
  end

  test "insert! should persist an valid Event" do
    repo = load_repo()

    event = %Event{
      actor: "mike",
      revision: 0,
      tags: %{},
      data_type: "type.googleapis.com/io.eigr.spawn.example.MyState",
      data: "Hello Joe"
    }

    _result = repo.save(event)
    actor_state = repo.get_by_key("mike")

    assert actor_state.data == "Hello Joe"
  end
end
