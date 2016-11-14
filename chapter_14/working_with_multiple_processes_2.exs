defmodule TokenReceiver do
  def process do
    receive do
      { sender, token } ->
        send sender, token
        process
    end
  end
end

receiver = spawn(TokenReceiver, :process, [])

send receiver, { self, "fred" }

receive do
  token ->
    IO.puts token
end

send receiver, { self, "betty" }

receive do
  token ->
    IO.puts token
end
