defmodule MyString do
  def center(string_list) when is_list(string_list) do
    Enum.each _padding(string_list), &IO.puts(&1)
  end

  defp _padding(string_list) do
    lengths = Enum.map(string_list, &String.length/1)
    max_length = Enum.max(lengths)
    for { str, length } <- Enum.zip(string_list, lengths) do
      String.rjust(str, length + div(max_length - length, 2))
    end
  end
end
