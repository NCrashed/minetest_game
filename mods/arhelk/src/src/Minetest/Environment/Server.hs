{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Minetest.Environment.Server(
    ServerEnvironment
  , whenServer
  ) where

import           Cpp
import           Data.Monoid
import           Foreign
import qualified Language.C.Inline     as C
import qualified Language.C.Inline.Cpp as C
import           Minetest.Cpp

C.context (C.cppCtx <> minetestCtx)
C.include "environment.h"

deriveParent ''Environment ''ServerEnvironment

-- | Run action only if the environment is server one
whenServer :: Applicative m => Ptr Environment -> (Ptr ServerEnvironment -> m ()) -> m ()
whenServer ptr m = case castToChild ptr of
  Nothing   -> pure ()
  Just cptr -> m cptr