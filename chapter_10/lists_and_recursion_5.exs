defmodule MyEnum do
  def all?(collection, func), do: _all?(collection, true, func)

  defp _all?(_collection, false, _func), do: false
  defp _all?([], _bool, _func), do: true
  defp _all?([head | tail], _bool, func), do: _all?(tail, func.(head), func)

  def each(collection, func), do: _each(collection, func)

  defp _each([], _func), do: :ok
  defp _each([head | tail], func) do
    func.(head)
    _each(tail, func)
  end

  def filter(collection, func), do: _filter(collection, [], func)

  defp _filter([], current, _func), do: current
  defp _filter([head | tail], current, func) do
    if func.(head) do
      current ++ [head] ++ _filter(tail, current, func)
    else
      current ++ _filter(tail, current, func)
    end
  end

  def split(collection, n), do: _split([], collection, n)

  defp _split(left, right, n) when right == [] when n == 0, do: {left, right}
  defp _split(left, [head | tail], n), do: _split(left ++ [head], tail, n - 1)

  def take(collection, n) do
    _take(collection, [], n)
  end

  defp _take(collection, current, n) when collection == [] when n == 0, do: current
  defp _take([head | tail], current, n), do: _take(tail, current ++ [head], n - 1)
end
