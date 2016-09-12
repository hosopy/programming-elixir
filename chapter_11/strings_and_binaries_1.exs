defmodule MyString do
  def has_ascii?(char_list) when is_list(char_list) do
    Enum.any? char_list, fn x -> x >= 32 and x <= 126 end
  end
end
