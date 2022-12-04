module Main where

import Data.Char
import Data.List
import System.IO

signScore sign
  | sign == 'X' = 1
  | sign == 'Y' = 2
  | sign == 'Z' = 3

resultScore a b =
  if a == 'A'
    then
      ( if b == 'X'
          then 3
          else
            if b == 'Y'
              then 6
              else 0
      )
    else
      if a == 'B'
        then
          ( if b == 'X'
              then 0
              else
                if b == 'Y'
                  then 3
                  else 6
          )
        else
          ( if b == 'X'
              then 6
              else
                if b == 'Y'
                  then 0
                  else 3
          )

lineScore :: [[Char]] -> Int
lineScore chars =
  (signScore (take 1 (chars !! 1) !! 0))
    + (resultScore (take 1 (chars !! 0) !! 0) (take 1 (chars !! 1) !! 0))

sumList :: [Int] -> Int
sumList [] = 0
sumList (a : b) = a + sumList b

abcIndex :: Char -> Int
abcIndex char = (ord char) - (ord 'A')

move :: String -> Int
move line =
  if b == 'X'
    then (((abcIndex a) + 2) `mod` 3) + 1
    else
      if b == 'Y'
        then 3 + (abcIndex a) + 1
        else 6 + (((abcIndex a) + 1) `mod` 3) + 1
  where
    chars = words line
    a = (chars !! 0) !! 0
    b = (chars !! 1) !! 0

part1 :: [String] -> Int
part1 inputLines = sumList (map (lineScore . words) inputLines)

part2 :: [String] -> Int
part2 inputLines = sumList (map move inputLines)

main = do
  input <- readFile "Input2.txt"
  print (part1 (lines input))
  print (part2 (lines input))