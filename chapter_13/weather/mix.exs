defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [app: :weather,
     escript: escript_config,
     version: "0.0.1",
     name: "Weather",
     source_url: "https://github.com/hosopy/programming-elixir/tree/master/chapter_13/weather",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :httpoison, "~> 0.8" },
      { :ex_doc, "~> 0.11" },
      { :earmark, ">= 0.0.0" }
    ]
  end

  defp escript_config do
    [ main_module: Weather.CLI ]
  end
end
