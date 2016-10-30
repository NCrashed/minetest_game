{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
module Minetest.Server(
    Server
  , withServerEnvLock
  , isSingleplayer
  ) where

import           Control.Monad.Base
import           Control.Monad.Catch
import           Data.Monoid
import           Foreign
import qualified Language.C.Inline     as C
import qualified Language.C.Inline.Cpp as C
import           Minetest.Cpp

C.context (C.cppCtx <> minetestCtx)
C.include "server.h"

-- | Lock server environment mutex. Required for some actions.
serverEnvLock :: Ptr Server -> IO ()
serverEnvLock ptr = [C.exp| void { $(Server *ptr)->m_env_mutex.lock() } |]

-- | Unlock server environment mutex. You should ALWAYS unlock it after
-- 'serverEnvLock'.
serverEnvUnlock :: Ptr Server -> IO ()
serverEnvUnlock ptr = [C.exp| void { $(Server *ptr)->m_env_mutex.unlock() } |]

-- | Perform action with server lock, the lock will be released after end of
-- action. Exception safe.
withServerEnvLock :: (MonadMask m, MonadBase IO m) => Ptr Server -> m a -> m a
withServerEnvLock ptr = bracket_ (liftBase $ serverEnvLock ptr) (liftBase $ serverEnvUnlock ptr)

-- | Returns 'True' for singleplayer
isSingleplayer :: Ptr Server -> IO Bool
isSingleplayer ptr = toBool <$> [C.exp| int { (int)$(Server *ptr)->isSingleplayer() } |]
