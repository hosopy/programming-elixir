defmodule MyList do
  # a is 97
  # z is 122
  def ceasar(list, n) when n >= 0 do
    map list, &(97 + rem(&1 + n - 122, 26) - 1)
  end

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]
end
