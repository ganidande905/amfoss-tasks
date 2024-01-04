defmodule PrimeNumbers do
  def is_prime(num) do
    if num < 2 do
      false
    else
      Enum.all?(2..round(:math.sqrt(num)), fn i -> rem(num, i) != 0 end)
    end
  end

  def print_primes(n) do
    IO.puts("Enter a number: ")
    input = IO.gets("")

    n = String.trim(input) |> String.to_integer()

    IO.puts("Prime numbers up to #{n}:")
    Enum.each(2..n, fn i ->
      if is_prime(i) do
        IO.puts(i)
      end
    end)
  end
end

PrimeNumbers.print_primes(10)
