module Minetest.Entrypoint(

  ) where

import Foreign
import Minetest.Server

foreign export ccall "modInit" c_modInit :: Ptr Server -> IO ()
foreign export ccall "modExit" c_modExit :: IO ()

c_modInit :: Ptr Server -> IO ()
c_modInit server = do
  putStrLn $ "Server pointer address: " ++ show server

c_modExit :: IO ()
c_modExit = return ()