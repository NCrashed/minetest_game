-- | Helpers for queue IO actions and run them when we need
module Cpp.Threading(
    runInMainThread
  , runAllMainThreadCallbacks
  ) where

import           Control.Concurrent.STM.TChan
import           Control.Monad.IO.Class
import           Control.Monad.STM            (atomically)
import           System.IO.Unsafe             (unsafePerformIO)

-- | Use this quque to pipe actions to be run in main thead
mainTheadCallbackQueue :: TChan (IO ())
mainTheadCallbackQueue = unsafePerformIO newTChanIO
{-# NOINLINE mainTheadCallbackQueue #-}

-- | Enqueue action to be run in main thread.
runInMainThread :: MonadIO m => IO () -> m ()
runInMainThread = liftIO . atomically . writeTChan mainTheadCallbackQueue

-- | Called by Urho, empties queue of callbacks and executes them.
runAllMainThreadCallbacks :: IO ()
runAllMainThreadCallbacks = do
  ios <- atomically $ extractCallbacks []
  sequence_ . reverse $ ios
  where
  extractCallbacks acc = do
    mio <- tryReadTChan mainTheadCallbackQueue
    case mio of
      Nothing -> return acc
      Just io -> extractCallbacks (io : acc)
