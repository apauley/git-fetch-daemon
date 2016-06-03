module Main where

import System.Environment (getArgs, getProgName)
import Lib

main :: IO ()
main = do
  exit <- shellDate
  me   <- getProgName
  args <- getArgs
  let (repoPath, sleepSeconds) = parseArgs args

  putStrLn $ usage me
  putStrLn $ "Fetching every " ++ show sleepSeconds ++ " seconds in " ++ show repoPath

  out <- fetch repoPath
  putStrLn $ show out

usage :: String -> String
usage me  = "Usage: " ++ me ++ " /path/to/repo sleepSeconds"
