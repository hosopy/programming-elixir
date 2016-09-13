defmodule MyString do
  def has_ascii?(char_list) when is_list(char_list) do
    Enum.any? char_list, fn x -> x >= ?\s and x <= ?~ end
  end
end
