defmodule MyList do
  def span(from, from) when is_integer(from) do
    [from]
  end

  def span(from, to) when is_integer(from) and is_integer(to) and from < to do
    [ from | span(from + 1, to) ]
  end
end
