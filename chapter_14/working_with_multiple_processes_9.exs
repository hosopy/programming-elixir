defmodule WordFinder do
  def find(scheduler) do
    send scheduler, { :ready, self }
    receive do
      { :execute, [ file: file, word: word ], client } ->
        send client, { :answer, [ file: file, word: word ], find_word_in_file(file, word), self }
        find(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  defp find_word_in_file(file, word) do
    file
    |> File.read!
    |> String.split
    |> Enum.filter(fn (token) -> String.match?(token, ~r/#{word}/) end)
    |> Enum.count
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, params_list) do
    (1..num_processes)
    |> Enum.map(fn (_) -> spawn(module, func, [self]) end)
    |> schedule_processes(params_list, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      { :ready, pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, { :execute, next, self }
        schedule_processes(processes, tail, results)
      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn { n1, _ }, { n2, _ } -> n1 <= n2 end)
        end
      { :answer, params, result, _pid } ->
        schedule_processes(processes, queue, [ { params, result } | results ])
    end
  end
end

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(
    Scheduler, :run,
    [
      num_processes,
      WordFinder, :find,
      Enum.map(File.ls!("tmp"), fn file -> [ file: "tmp/#{file}", word: "cat" ] end)
    ]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B     ~.2f~n", [ num_processes, time/1000000.0 ]
end
