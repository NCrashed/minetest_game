{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Minetest.Environment.Client(
    ClientEnvironment
  , whenClient
  ) where

import           Cpp
import           Data.Monoid
import           Foreign
import qualified Language.C.Inline     as C
import qualified Language.C.Inline.Cpp as C
import           Minetest.Cpp

C.context (C.cppCtx <> minetestCtx)
C.include "environment.h"

deriveParent ''Environment ''ClientEnvironment

-- | Run action only if the environment is client one
whenClient :: Applicative m => Ptr Environment -> (Ptr ClientEnvironment -> m ()) -> m ()
whenClient ptr m = case castToChild ptr of
  Nothing   -> pure ()
  Just cptr -> m cptr
