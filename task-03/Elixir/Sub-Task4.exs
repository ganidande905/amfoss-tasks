n = String.to_integer(File.read!("input.txt"))
File.open!("output.txt", [:write], fn file ->
  for i <- 0..(n-1) do
    IO.write(file, String.duplicate(" ", n-i-1) <> String.duplicate("*", 2*i + 1) <> "\n")
  end
  for i <- (n-2)..0 do
    IO.write(file, String.duplicate(" ", n-i-1) <> String.duplicate("*", 2*i + 1) <> "\n")
  end
end)
