{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Minetest.Environment.Server(
    ServerEnvironment
  ) where

import           Cpp
import           Data.Monoid
import qualified Language.C.Inline     as C
import qualified Language.C.Inline.Cpp as C
import           Minetest.Cpp

C.context (C.cppCtx <> minetestCtx)
C.include "environment.h"

deriveParent ''Environment ''ServerEnvironment
