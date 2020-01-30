module Main where

import qualified Data.ByteString.Lazy.Internal as C
import Data.Aeson
import Data.List
import Control.Arrow
import Lib

main :: IO ()
main = res >>= putStrLn
       where res = (process >>> resultAsString) <$> ((eitherDecodeFileStrict "../input.json") :: IO (Either String [Activity]))

resultAsString :: Either String C.ByteString -> String
resultAsString (Right res)  = C.unpackChars res
resultAsString (Left  e)    = "Something went wrong" ++ e

process :: Either String [Activity] -> Either String C.ByteString
process decoded = (onlyComments >>> encode) <$> decoded

onlyComments :: [Activity] -> [Activity]
onlyComments activites = filter isComment activites

isComment :: Activity -> Bool
isComment (Comment _ _) = True
isComment otherwise     = False
