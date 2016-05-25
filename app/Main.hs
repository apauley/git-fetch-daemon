module Main where

import System.Environment (getArgs)
import Lib

main :: IO ()
main = do
  _exitCode <- shellDate
  args <- getArgs
  let (repoPath, sleepSeconds) = parseArgs args
  putStrLn $ "Fetching every " ++ show sleepSeconds ++ " seconds in " ++ show repoPath
