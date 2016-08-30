defmodule Chop do
  def guess(actual, min..max) when is_integer(actual) and
                                   is_integer(min) and
                                   is_integer(max) and
                                   actual in min..max do
    guess = div(min + max, 2)
    IO.puts "Is it #{guess}"
    internal_guess(actual, guess, min..max)
  end

  defp internal_guess(actual, actual, _) do
    IO.puts actual
  end

  defp internal_guess(actual, guess, _..max) when guess < actual do
    guess(actual, guess + 1..max)
  end

  defp internal_guess(actual, guess, min.._) when guess > actual do
    guess(actual, min..guess - 1)
  end
end
