fizz_buzz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, c) -> c
end

fizz_buzz_wrapper = fn n -> fizz_buzz.(rem(n, 3), rem(n, 5), n) end

IO.puts fizz_buzz_wrapper.(10)
IO.puts fizz_buzz_wrapper.(11)
IO.puts fizz_buzz_wrapper.(12)
IO.puts fizz_buzz_wrapper.(13)
IO.puts fizz_buzz_wrapper.(14)
IO.puts fizz_buzz_wrapper.(15)
IO.puts fizz_buzz_wrapper.(16)
