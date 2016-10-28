{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
module Minetest.Cpp(
    Server
  , minetestCtx
  ) where

import qualified Language.C.Inline as C
import qualified Language.C.Inline.Context as C
import qualified Language.C.Types as C

import qualified Data.Map as Map

-- | Minetest server tag
data Server

minetestCtx :: C.Context
minetestCtx = mempty {
    C.ctxTypesTable = Map.fromList [
      (C.TypeName "Server", [t| Server |])
    ]
  }