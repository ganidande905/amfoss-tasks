import System.IO

main = do
    input <- readFile "input.txt"
    let n = read input :: Int
    let lines = [replicate (n-i-1) ' ' ++ replicate (2*i+1) '*' | i <- [0..n-1]]
            ++ [replicate (n-i-1) ' ' ++ replicate (2*i+1) '*' | i <- [n-2,n-3..0]]
    writeFile "output.txt" (unlines lines)
