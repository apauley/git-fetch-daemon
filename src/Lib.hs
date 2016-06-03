{-# LANGUAGE OverloadedStrings #-}

module Lib
    (parseArgs
    , fetch
    ) where

import Prelude hiding (FilePath, log)
import Filesystem.Path.CurrentOS (decodeString)
import Data.Text (pack)
import Turtle

parseArgs :: [String] -> (FilePath, NominalDiffTime)
parseArgs [repoPath] = (decodeString repoPath, defaultSleepSeconds)
parseArgs (repoPath:s:_) = (decodeString repoPath, realToFrac $ read s)
parseArgs _ = (decodeString ".", defaultSleepSeconds)

fetch :: FilePath -> NominalDiffTime -> IO ()
fetch repoDir sleepSeconds = do
  cd repoDir
  dir <- pwd

  fetchOne dir .||. die (format ("Error fetching in "%fp%". Is this a git repository?") dir)

  log $ format ("Fetching every "%s%" in " %fp% "") (pack $ show sleepSeconds) dir
  fetchEvery dir sleepSeconds

fetchEvery :: FilePath -> NominalDiffTime -> IO ()
fetchEvery dir sleepSeconds = do
  sleep sleepSeconds
  fetchOne dir
  fetchEvery dir sleepSeconds

fetchOne :: FilePath -> IO ExitCode
fetchOne dir = do
  log $ format ("Running a git fetch in " %fp) dir
  exitCode <- shell "git fetch" empty
  log $ format ("Done running a git fetch in " %fp% " - "%s%"\n") dir $ pack $ show exitCode
  return exitCode

defaultSleepSeconds = 120

log :: Text -> IO ()
log msg = do
  now <- dateString
  echo $ format (s%" - "%s) now msg

dateString :: IO Text
dateString = do
  d <- date
  return $ pack $ show d
