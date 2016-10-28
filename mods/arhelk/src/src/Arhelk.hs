module Arhelk(
    someFunc
  ) where

import Foreign.C

foreign export ccall "someFunc" c_someFunc :: CString -> IO CString
foreign export ccall "modInit" c_modInit :: IO ()
foreign export ccall "modExit" c_modExit :: IO ()

c_someFunc :: CString -> IO CString
c_someFunc n = do
  n' <- peekCString n
  let s = someFunc n'
  newCString s

someFunc :: String -> String
someFunc n = "Hello, dear " ++ n ++ "!"

c_modInit :: IO ()
c_modInit = return ()

c_modExit :: IO ()
c_modExit = return ()