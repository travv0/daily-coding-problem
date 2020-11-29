-- There exists a staircase with N steps, and you can climb up either 1 or 2
-- steps at a time. Given N, write a function that returns the number of unique
-- ways you can climb the staircase. The order of the steps matters.
--
-- For example, if N is 4, then there are 5 unique ways:
--
--     1, 1, 1, 1
--     2, 1, 1
--     1, 2, 1
--     1, 1, 2
--     2, 2
--
-- What if, instead of being able to climb 1 or 2 steps at a time, you could
-- climb any number from a set of positive integers X? For example, if X = {1,
-- 3, 5}, you could climb 1, 3, or 5 steps at a time.

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
