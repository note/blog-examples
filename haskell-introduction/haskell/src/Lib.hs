{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( Activity(BlogPost, Comment)
    ) where

import Data.Aeson
import GHC.Generics

data Activity = BlogPost { id       :: Int
                         , title    :: String
                         , summary  :: String
                         }
              | Comment  { blogPostId :: Int
                         , content    :: String
                         }
              deriving (Generic, Show)

instance ToJSON Activity
