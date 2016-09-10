defmodule MyList do
  def span(from, from) when is_integer(from) do
    [from]
  end

  def span(from, to) when is_integer(from) and is_integer(to) and from < to do
    [ from | span(from + 1, to) ]
  end
end

defmodule MyNumber do
  import MyList

  def primes(n) when is_integer(n) and n > 2 do
    for x <- span(2, n), prime?(x), do: x
  end

  defp prime?(2), do: true
  defp prime?(x), do: Enum.all?(span(2, x - 1), &(rem(x, &1) !== 0))
end
