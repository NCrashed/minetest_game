module Arhelk(
    someFunc
  ) where

--import Foreign
import Foreign.C

foreign export ccall "someFunc" c_someFunc :: CString -> IO CString

c_someFunc :: CString -> IO CString
c_someFunc n = do
  n' <- peekCString n
  let s = someFunc n'
  newCString s

someFunc :: String -> String
someFunc n = "Hello, dear " ++ n ++ "!"
