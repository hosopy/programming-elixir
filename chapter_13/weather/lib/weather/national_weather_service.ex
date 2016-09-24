defmodule Weather.NationalWeatherService do
  require Logger

  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  @user_agent [ {"User-agent", "Elixir hosopy"} ]
  @nws_url Application.get_env(:weather, :nws_url)
  @display_fields Application.get_env(:weather, :display_fields)

  def fetch_current_obs(code) do
    Logger.info "Fetching location #{code}'s data"
    current_obs_url(code)
    |> HTTPoison.get(@user_agent)
    |> handle_response
    |> decode_response
  end

  def current_obs_url(code) do
    "#{@nws_url}/xml/current_obs/#{String.upcase(code)}.xml"
  end

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    { :ok, body }
  end

  def handle_response({ _, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    { :error, body }
  end

  def decode_response({:ok, body}) do
    body
    |> scan_response
    |> extract_nodes(@display_fields)
  end

  def decode_response({:error, error}) do
    IO.puts "Error fetching from NWS: #{error}"
    System.halt(2)
  end

  def scan_response(body) do
    body
    |> String.to_char_list
    |> :xmerl_scan.string
  end

  def extract_nodes({xml, _}, node_names) do
    Enum.into(node_names, %{}, &(extract_node(xml, &1)) )
  end

  def extract_node(xml, node_name) do
    [element]  = :xmerl_xpath.string(String.to_char_list("/current_observation/#{node_name}"), xml)
    [text] = xmlElement(element, :content)
    value = xmlText(text, :value)
    { String.to_atom(node_name), to_string(value) }
  end
end
