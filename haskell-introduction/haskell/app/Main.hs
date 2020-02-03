module Main where

import qualified Data.ByteString.Lazy.Internal as C
import Data.Aeson
import Data.List
import Control.Arrow
import Lib

main :: IO ()
main = do activitiesEither <- eitherDecodeFileStrict "../input.json" :: IO (Either String [Activity])
          let output = case activitiesEither of 
                            (Right activities) -> C.unpackChars $ process activities
                            (Left e)           -> "Something went wrong: " ++ e
              in (putStrLn output)

process :: [Activity] -> C.ByteString
process activities = encode $ onlyComments activities

onlyComments :: [Activity] -> [Activity]
onlyComments activites = filter isComment activites

isComment :: Activity -> Bool
isComment (Comment _ _) = True
isComment otherwise     = False
