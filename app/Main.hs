module Main where

import Lib

main :: IO ()
main = do
  exitCode <- shellDate
  putStrLn $ show exitCode
