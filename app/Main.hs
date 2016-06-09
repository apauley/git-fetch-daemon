{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import System.Environment (getProgName)
import Lib

main :: IO ()
main = do
  me   <- getProgName
  args <- arguments
  let (repoPath, sleepSeconds) = parseArgs args

  putStrLn $ usage me
  fetch repoPath sleepSeconds

usage :: String -> String
usage me = "Usage: " ++ me ++ " /path/to/repo sleepSeconds\n"
