defmodule Link do
  import :timer, only: [ sleep: 1 ]

  def sad_function(parent_pid) do
    send parent_pid, "hello"
    exit(:boom)
  end

  def run do
    spawn_link(Link, :sad_function, [self])

    sleep 500

    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
      after 1000 ->
        IO.puts "Timeout"
    end
  end
end

Link.run
