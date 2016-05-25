{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( shellDate
    , parseArgs
    ) where

import Turtle

parseArgs :: [String] -> (String, Int)
parseArgs [repoPath] = (repoPath, defaultSleepSeconds)
parseArgs (repoPath:s:_) = (repoPath, read s)
parseArgs _ = (".", defaultSleepSeconds)

shellDate :: IO ExitCode
shellDate = shell "date" empty

defaultSleepSeconds = 180
