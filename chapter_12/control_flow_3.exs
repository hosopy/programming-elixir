defmodule Util do
  def ok!({ :ok, data }), do: data

  def ok!(arg), do: raise "Error #{inspect(arg)}"
end
