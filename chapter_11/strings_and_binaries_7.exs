defmodule OrderProcessor do
  def sales_tax(orders, tax_rates) do
    Enum.map orders, fn
      [ id: id, ship_to: ship_to, net_amount: net_amount] ->
        [ id: id, ship_to: ship_to, net_amount: net_amount,
          total_amount: net_amount + net_amount * Keyword.get(tax_rates, ship_to, 0)]
    end
  end

  def sales_tax_from_order_file(file, tax_rates) do
    { :ok, fp } = File.open(file, [:read, :utf8])
    IO.stream(fp, :line)
    |> Stream.drop(1)
    |> Enum.map(&String.strip/1)
    |> Enum.map(&_parse_line/1)
    |> sales_tax(tax_rates)
  end

  defp _parse_line(line) do
    [ id, ship_to, net_amount ] = String.split(line, ",")
    [ id: String.to_integer(id), ship_to: String.to_atom(ship_to), net_amount: String.to_float(net_amount) ]
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

IO.inspect OrderProcessor.sales_tax_from_order_file("orders.csv", tax_rates)
