defmodule MyString do
  def capitalize_sentences(str) when is_binary(str), do: _capitalize_sentences(str, "", &String.upcase/1)

  defp _capitalize_sentences(<<>>, current, _next_func), do: current

  defp _capitalize_sentences(<< head :: utf8, tail :: binary >>, current, _next_func)
                            when head == ?\s when head == ?. do
    _capitalize_sentences(tail, current <> << head >>, &String.upcase/1)
  end

  defp _capitalize_sentences(<< head :: utf8, tail :: binary >>, current, next_func) do
    _capitalize_sentences(tail, current <> next_func.(<< head >>), &String.downcase/1)
  end
end
