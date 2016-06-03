{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( shellDate
    , parseArgs
    , fetch
    ) where

import Prelude hiding (FilePath)
import Filesystem.Path.CurrentOS (decodeString)
import Turtle

parseArgs :: [String] -> (FilePath, Int)
parseArgs [repoPath] = (decodeString repoPath, defaultSleepSeconds)
parseArgs (repoPath:s:_) = (decodeString repoPath, read s)
parseArgs _ = (decodeString ".", defaultSleepSeconds)

shellDate :: IO ExitCode
shellDate = shell "date" empty

fetch :: FilePath -> IO ExitCode
fetch dir = do
  cd dir
  shell "git fetch" empty

defaultSleepSeconds = 180
