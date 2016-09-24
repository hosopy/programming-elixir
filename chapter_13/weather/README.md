# Weather

This application fetches weather data at the location specified by a code.
Available code can be found at http://w1.weather.gov/xml/current_obs/.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add weather to your list of dependencies in `mix.exs`:

        def deps do
          [{:weather, "~> 0.0.1"}]
        end

  2. Ensure weather is started before your application:

        def application do
          [applications: [:weather]]
        end
