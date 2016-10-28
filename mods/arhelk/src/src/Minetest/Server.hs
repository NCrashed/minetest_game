{-# LANGUAGE TemplateHaskell #-}
module Minetest.Server(
    Server
  ) where

import Data.Monoid

import Minetest.Cpp

import qualified Language.C.Inline as C
import qualified Language.C.Inline.Cpp as C

C.context (C.cppCtx <> minetestCtx)
C.include "server.h"