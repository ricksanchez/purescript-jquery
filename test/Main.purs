module Test.Main where

import Prelude hiding (append)

import Data.Either
import Data.Foreign
import Data.Foreign.Class

import Control.Monad.Eff
import Control.Monad.Eff.Console
import Control.Monad.Eff.JQuery

main = ready $ do
  -- Get the document body
  body <- body

  -- Create a text box
  div   <- create "<div>"
  input <- create "<input>"
  appendText "Your Name: " div
  append input div
  append div body

  -- Create a paragraph to display a greeting
  greeting <- create "<p>"
  css { color: "red" } greeting
  append greeting body

  -- Listen for change events on the text box
  on "change" (handleChange input greeting) input 
  where
  handleChange input greeting _ _ = do
    Right name <- read <$> getValue input
    log $ "Name changed to " ++ name
    setText ("Hello, " ++ name) greeting
