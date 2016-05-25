module Main where

import System.Environment (getArgs)
import Lib

main :: IO ()
main = do
  _exitCode <- shellDate
  [repoPath, sleepSeconds] <- getArgs
  putStrLn $ "Fetching in " ++ repoPath ++ " every " ++ show sleepSeconds ++ " seconds"
