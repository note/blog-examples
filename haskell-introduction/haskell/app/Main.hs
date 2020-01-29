module Main where

import qualified Data.ByteString.Lazy.Internal as C
import Data.Aeson
import Lib

main :: IO ()
main = let example = Comment 5 "Some comment"
           encoded = encode example
       in  putStrLn $ C.unpackChars encoded
