module Minetest.Entrypoint(

  ) where

import Foreign
import Minetest.Server
import Minetest.Environment
import Minetest.Environment.Server
import Minetest.Environment.Client
import Minetest.GUIEngine

foreign export ccall "modInit" c_modInit :: Ptr Server -> IO ()
foreign export ccall "modInitEnvironment" c_modInitEnvironment :: Ptr Environment -> IO ()
foreign export ccall "modInitGUIEngine" c_modInitGUIEngine :: Ptr GUIEngine -> IO ()
foreign export ccall "modExit" c_modExit :: IO ()

c_modInit :: Ptr Server -> IO ()
c_modInit server = do
  res <- isSingleplayer server
  putStrLn $ "Server isSingleplayer: " ++ show res

c_modInitEnvironment :: Ptr Environment -> IO ()
c_modInitEnvironment ptr = do
  putStrLn $ "Environment ptr: " ++ show ptr
  whenServer ptr $ const $ putStrLn "Mod is server side"
  whenClient ptr $ const $ putStrLn "Mod is client side"

c_modInitGUIEngine :: Ptr GUIEngine -> IO ()
c_modInitGUIEngine ptr = do
  putStrLn $ "GUIEngine ptr: " ++ show ptr

c_modExit :: IO ()
c_modExit = return ()