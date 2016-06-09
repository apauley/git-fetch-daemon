{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import Prelude hiding (FilePath, log)
import Filesystem.Path.CurrentOS (fromText)
import Data.Text (pack)

defaultSleepSeconds = 120

main :: IO ()
main = do
  (repoPath, maybeSecs) <- options "Runs a `git fetch` continuously for a given repository" parser

  case maybeSecs of
    Nothing   -> fetch repoPath defaultSleepSeconds
    Just secs -> fetch repoPath $ realToFrac secs

parser :: Parser (FilePath, Maybe Int)
parser = (,) <$> argPath "repo"  "The path to a git repository"
             <*> optional (argInt "sleepSeconds" "The number of seconds to sleep between fetches.")

fetch :: FilePath -> NominalDiffTime -> IO ()
fetch repoDir sleepSeconds = do
  cd repoDir
  dir <- pwd

  fetchOne dir .||. die (format ("Error fetching in "%fp%". Is this a git repository?") dir)

  log $ format ("Fetching every "%s%" in " %fp% "") (pack $ show sleepSeconds) dir
  fetchEvery dir sleepSeconds

fetchOne :: FilePath -> IO ExitCode
fetchOne dir = do
  log $ format ("Running a git fetch in " %fp) dir
  exitCode <- shell "git fetch" empty
  log $ format ("Done running a git fetch in " %fp% " - "%s%"\n") dir $ pack $ show exitCode
  return exitCode

fetchEvery :: FilePath -> NominalDiffTime -> IO ()
fetchEvery dir sleepSeconds = do
  sleep sleepSeconds
  fetchOne dir
  fetchEvery dir sleepSeconds

log :: Text -> IO ()
log msg = do
  now <- dateString
  echo $ format (s%" - "%s) now msg

dateString :: IO Text
dateString = do
  d <- date
  return $ pack $ show d
