isPrime :: Int -> Bool
isPrime num
  | num < 2 = False
  | otherwise = all (\i -> num `mod` i /= 0) [2..floor (sqrt (fromIntegral num))]

main :: IO ()
main = do
  putStrLn "Enter a number: "
  input <- getLine
  let n = read input :: Int

  putStrLn $ "Prime numbers up to " ++ show n ++ ":"
  mapM_ (\i -> if isPrime i then print i else return ()) [2..n]
