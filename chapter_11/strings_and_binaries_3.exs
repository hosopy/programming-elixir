defmodule Parse do
  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str), do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value)
  when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "Invalid digit '#{non_digit}'"
  end
end

defmodule Calculator do
  import Parse

  def calculate(expression) when is_list(expression) do
    %{ lhs: lhs, rhs: rhs, op: op } = _parse(expression, %{ lhs: [], op: [], rhs: [] })
    _calculate(number(lhs), number(rhs), op)
  end

  defp _parse([], tokens), do: tokens

  defp _parse([ digit | tail ], %{ lhs: lhs, op: [], rhs: [] }) when digit in '0123456789' do
    _parse(tail, %{ lhs: lhs ++ [ digit ], op: [], rhs: [] })
  end

  defp _parse([ digit | tail ], %{ lhs: lhs, op: op, rhs: rhs }) when digit in '0123456789' do
    _parse(tail, %{ lhs: lhs, op: op, rhs: rhs ++ [ digit ] })
  end

  defp _parse([ space | tail ], tokens) when space in '\s', do: _parse(tail, tokens)

  defp _parse([ operator | tail ], %{ lhs: lhs, op: [], rhs: [] }) when operator in '+-*/' do
    _parse(tail, %{ lhs: lhs, op: [operator], rhs: [] })
  end

  defp _calculate(x, y, op) when op === '+', do: x + y
  defp _calculate(x, y, op) when op === '-', do: x - y
  defp _calculate(x, y, op) when op === '*', do: x * y
  defp _calculate(x, y, op) when op === '/', do: x / y
end
