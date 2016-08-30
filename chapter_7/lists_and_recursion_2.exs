defmodule MyList do
  def max(list), do: _max(list)

  defp _max([a]), do: a
  defp _max([head | tail]), do: _greater(head, _max(tail))
  defp _greater(a, b) when a >= b, do: a
  defp _greater(a, b) when a < b, do: b
end
