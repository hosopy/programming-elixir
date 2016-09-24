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
  defp parse_args(argv) do
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
    |> IO.inspect
  end
end
