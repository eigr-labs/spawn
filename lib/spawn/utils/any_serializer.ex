defmodule Spawn.Utils.AnySerializer do
  @moduledoc """
  `AnySerializer` is responsible for serializing the protobuf type Any to Elixir
  structures and vice versa.
  """

  alias Google.Protobuf.Any

  def unpack_any_bin(bin),
    do:
      Any.decode(bin)
      |> unpack_unknown()

  def unpack_unknown({:value, any}), do: unpack_unknown(any)
  def unpack_unknown({:noop, any}), do: unpack_unknown(any)

  def unpack_unknown(%{type_url: type_url} = any) do
    package_name =
      type_url
      |> String.replace("type.googleapis.com/", "")
      |> String.split(".")
      |> Enum.map_join(".", &upcase_first/1)
      |> then(fn package -> Enum.join(["Elixir", package], ".") end)

    any_unpack!(any, String.to_existing_atom(package_name))
  end

  def unpack_unknown(_), do: nil

  def any_pack!(nil), do: nil

  def any_pack!(%Any{} = record), do: record

  def any_pack!(record) do
    Any.new(
      type_url: get_type_url(record.__struct__),
      value: apply(record.__struct__, :encode, [record])
    )
  end

  def any_unpack!(any_record, builder) do
    builder.decode(any_record.value)
  end

  defp get_type_url(type) do
    parts =
      type
      |> to_string
      |> String.replace("Elixir.", "")
      |> String.split(".")

    package_name =
      with {_, list} <- parts |> List.pop_at(-1),
           do: Enum.map_join(list, ", ", &String.downcase/1)

    type_name = parts |> List.last()

    "type.googleapis.com/#{package_name}.#{type_name}"
  end

  defp upcase_first(<<first::utf8, rest::binary>>), do: String.upcase(<<first::utf8>>) <> rest
end
