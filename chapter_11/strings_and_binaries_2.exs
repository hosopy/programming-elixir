defmodule MyString do
  def anagram?(word1, word2) do
    _count_by_char(_normalize(word1)) == _count_by_char(_normalize(word2))
  end

  defp _normalize(word), do: Regex.replace(~r/\s/, String.upcase(word), "")

  defp _count_by_char(word) do
    Enum.reduce String.codepoints(word), %{}, &_update_count/2
  end

  def _update_count(char, acc) do
    Map.update acc, String.to_atom(char), 1, &(&1 + 1)
  end
end
