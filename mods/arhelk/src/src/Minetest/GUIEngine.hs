{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
module Minetest.GUIEngine(
    GUIEngine
  ) where

import           Data.Monoid
import qualified Language.C.Inline     as C
import qualified Language.C.Inline.Cpp as C
import           Minetest.Cpp

C.context (C.cppCtx <> minetestCtx)
C.include "guiEngine.h"