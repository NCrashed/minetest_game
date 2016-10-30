-- | Catch idea of different types of pointers in CPP
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
module Cpp.Pointer(
    Pointer(..)
  , mkParentPointer
  , parentPointer
  ) where

import           Cpp.Parent
import           Foreign

-- | Relation between types, where a is pointer for b
class Pointer pointer ptype | pointer -> ptype where
  pointer :: pointer -> Ptr ptype
  isNull :: pointer -> Bool
  makePointer :: Ptr ptype -> pointer

instance Pointer (Ptr a) a where
  pointer = id
  isNull p = p == nullPtr
  makePointer = id

-- | If me have pointer to child, we have pointer to parent
mkParentPointer :: (Parent parent child, Pointer p1 child, Pointer p2 parent) => p1 -> p2
mkParentPointer = makePointer . parentPointer

-- | If me have pointer to child, we have pointer to parent
parentPointer :: (Parent parent child, Pointer p1 child) => p1 -> Ptr parent
parentPointer = castToParent . pointer
