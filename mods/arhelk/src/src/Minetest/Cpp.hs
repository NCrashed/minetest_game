{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
module Minetest.Cpp(
    Server
  , Environment
  , GUIEngine
  , minetestCtx
  ) where

import qualified Language.C.Inline as C
import qualified Language.C.Inline.Context as C
import qualified Language.C.Types as C

import qualified Data.Map as Map

-- | Minetest server tag
data Server

-- | Minetest Environment
data Environment

-- | Minetest GUIEngine
data GUIEngine

minetestCtx :: C.Context
minetestCtx = mempty {
    C.ctxTypesTable = Map.fromList [
      (C.TypeName "Server", [t| Server |])
    , (C.TypeName "Environment", [t| Environment |])
    , (C.TypeName "GUIEngine", [t| GUIEngine |])
    ]
  }