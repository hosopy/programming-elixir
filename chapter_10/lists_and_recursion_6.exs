defmodule MyEnum do
  def flatten(collection), do: _flatten(collection, [])

  defp _flatten([], current), do: current
  defp _flatten([head | tail], current) when is_list(head), do: _flatten(head ++ tail, current)
  defp _flatten([head | tail], current), do: _flatten(tail, current ++ [head])
end
