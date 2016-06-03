{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import System.Environment (getArgs, getProgName)
import Lib

main :: IO ()
main = do
  me   <- getProgName
  args <- getArgs
  let (repoPath, sleepSeconds) = parseArgs args

  putStrLn $ usage me
  fetch repoPath sleepSeconds

usage :: String -> String
usage me  = "Usage: " ++ me ++ " /path/to/repo sleepSeconds"
