{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import Prelude hiding (FilePath, log)
import Lib

main :: IO ()
main = do
  (repoPath, secs) <- options "Runs a `git fetch` continuously for a given repository" parser

  let sleepSeconds = realToFrac secs
  fetch repoPath sleepSeconds

parser :: Parser (FilePath, Int)
parser = (,) <$> argPath "repo"  "The path to a git repository"
             <*> argInt "sleepSeconds" "The number of seconds to sleep between fetches"
