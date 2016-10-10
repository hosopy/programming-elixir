defmodule Weather.CLI do

  @moduledoc """
  This application fetches weather data at the location specified by a code.
  Available code can be found at http://w1.weather.gov/xml/current_obs/.
  Code Examples: KALB (Albany International Airport)
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a location code.
  Return a tuple of `{ code }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help])
    case parse do
      { [ help: true ], _, _ }
        -> :help
      { _, [ code ], _ }
        -> { code }
      _ -> :help
    end
  end

  defp process(:help) do
    IO.puts """
    usage: weather <code>
    """
    System.halt(0)
  end

  defp process({code}) do
    Weather.NationalWeatherService.fetch_current_obs(code)
    |> print_map
  end

  defp print_map(map) do
    with max_key_length = max_key_length(map)
    do
      map
      |> Enum.map(fn {k, v} -> "#{String.ljust(Atom.to_string(k), max_key_length)} : #{v}" end)
      |> Enum.join("\n")
      |> IO.puts
    end
  end

  defp max_key_length(map) do
    map
    |> Map.keys
    |> Enum.map(fn (key) -> String.length(Atom.to_string(key)) end)
    |> Enum.max
  end
end
