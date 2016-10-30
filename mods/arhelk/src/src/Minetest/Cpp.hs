{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
module Minetest.Cpp(
    Server
  , Environment
  , ClientEnvironment
  , ServerEnvironment
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

-- | Client extension of 'Environment'
data ClientEnvironment

-- | Server extension of 'Environment'
data ServerEnvironment

-- | Minetest GUIEngine
data GUIEngine

minetestCtx :: C.Context
minetestCtx = mempty {
    C.ctxTypesTable = Map.fromList [
      (C.TypeName "Server", [t| Server |])
    , (C.TypeName "Environment", [t| Environment |])
    , (C.TypeName "ClientEnvironment", [t| ClientEnvironment |])
    , (C.TypeName "ServerEnvironment", [t| ServerEnvironment |])
    , (C.TypeName "GUIEngine", [t| GUIEngine |])
    ]
  }