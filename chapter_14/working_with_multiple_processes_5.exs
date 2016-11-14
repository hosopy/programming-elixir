defmodule Monitor do
  import :timer, only: [ sleep: 1 ]

  def sad_function(parent_pid) do
    send parent_pid, "hello"
    raise "hogehoge"
  end

  def run do
    spawn_monitor(Monitor, :sad_function, [self])

    sleep 500

    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
      after 1000 ->
        IO.puts "Timeout"
    end
  end
end

Monitor.run
