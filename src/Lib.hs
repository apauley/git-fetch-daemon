{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( shellDate
    ) where

import Turtle

shellDate :: IO ExitCode
shellDate = shell "date" empty
