module Main where

import Control.Exception (assert)
import Data.List (nub)

main :: IO ()
main =
    let test1 = uniqueWaysToClimb [1, 2] 4
        test2 = uniqueWaysToClimb [1, 3, 5] 6
     in do
            print $ assert (length test1 == 5) test1
            print $ assert (length test2 == 8) test2

uniqueWaysToClimb :: [Int] -> Int -> [[Int]]
uniqueWaysToClimb stepsAtATime steps =
    let ns = nub stepsAtATime
     in uniqueWaysToClimb' ns steps ns
  where
    uniqueWaysToClimb' :: [Int] -> Int -> [Int] -> [[Int]]
    uniqueWaysToClimb' (n : ns) steps' allAtATimes
        | n == steps' = [[n]]
        | n < steps' =
            map (n :) (uniqueWaysToClimb' allAtATimes (steps' - n) allAtATimes)
                ++ uniqueWaysToClimb' ns steps' allAtATimes
    uniqueWaysToClimb' _ _ _ = []
