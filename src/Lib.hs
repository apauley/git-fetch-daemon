{-# LANGUAGE OverloadedStrings #-}

module Lib
    (parseArgs
    , fetch
    ) where

import Prelude hiding (FilePath)
import Filesystem.Path.CurrentOS (decodeString)
import Data.Text (pack)
import Turtle

parseArgs :: [String] -> (FilePath, NominalDiffTime)
parseArgs [repoPath] = (decodeString repoPath, defaultSleepSeconds)
parseArgs (repoPath:s:_) = (decodeString repoPath, realToFrac $ read s)
parseArgs _ = (decodeString ".", defaultSleepSeconds)

fetch :: FilePath -> NominalDiffTime -> IO ()
fetch dir sleepSeconds = do
  cd dir

  now1 <- dateString
  echo $ format (s%" Fetching " %fp% "") now1 dir

  exitCode <- shell "git fetch" empty

  now2 <- dateString
  echo $ format (s%" Fetched " %fp% " "%s%"\n") now2 dir $ pack $ show exitCode

  sleep sleepSeconds
  fetch dir sleepSeconds

defaultSleepSeconds = 120

dateString :: IO Text
dateString = do
  d <- date
  return $ pack $ show d
