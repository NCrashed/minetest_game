module Minetest.Entrypoint(

  ) where

import Foreign
import Minetest.Server
import Minetest.Environment
import Minetest.GUIEngine

foreign export ccall "modInit" c_modInit :: Ptr Server -> Ptr Environment -> Ptr GUIEngine -> IO ()
foreign export ccall "modExit" c_modExit :: IO ()

c_modInit :: Ptr Server -> Ptr Environment -> Ptr GUIEngine -> IO ()
c_modInit server _ _ = do
  res <- isSingleplayer server
  putStrLn $ "Server isSingleplayer: " ++ show res

c_modExit :: IO ()
c_modExit = return ()