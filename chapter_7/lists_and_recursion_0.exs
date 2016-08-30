defmodule MyList do
  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum(tail, head + total)

  # sum without using accumulator
  def sum2(list) do
    total = 0
    add_total = fn (n) -> total + n end
    _sum2(list, add_total)
  end

  defp _sum2([], func), do: func.(0)
  defp _sum2([head | tail], func), do: head + _sum2(tail, func)
end
