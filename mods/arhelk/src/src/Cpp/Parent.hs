-- | Catch parent relation in CPP world
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
module Cpp.Parent(
    Parent(..)
  , deriveParent
  , deriveParents
  ) where

import           Language.Haskell.TH
import           Language.Haskell.TH.Quote

import           Data.Monoid
import           Foreign
import qualified Language.C.Inline         as C

-- | Relation between classes, where a is parent for b
class Parent parent child where
  castToParent :: Ptr child -> Ptr parent
  castToChild :: Ptr parent -> Maybe (Ptr child)

instance Parent a a where
  castToParent = id
  castToChild = Just

-- | Generates instance for parentize relation
--
-- @@
-- instance Parent ParentType ChildType where
--   castToParent ptr = [C.pure| ParentType* {(ParentType*)$(ChildType* ptr)} |]
--   castToChild ptr = let
--     child = [C.pure| ChildType* {(ChildType*)$(ParentType* ptr)} |]
--     in if child == nullPtr then Nothing else Just child
-- @@
deriveParent :: Name -> Name -> DecsQ
deriveParent parentName childName = do
  [d|
    instance Parent $parentType $childType where
      castToParent _ptr = $(quoteExp C.pure $ parentStr <> "* {(" <> parentStr <> "*)$(" <> childStr <> "* _ptr)}" )
      castToChild _ptr = let
        child = $(quoteExp C.pure $ childStr <> "* {(" <> childStr <> "*)$(" <> parentStr <> "* _ptr)}" )
        in if child == nullPtr then Nothing else Just child
    |]
  where
    parentType = conT parentName
    parentStr = nameBase parentName
    childType = conT childName
    childStr = nameBase childName

-- | Generate instance for parentize relation for set of parent types
--
-- See: 'deriveParent'
deriveParents :: [Name] -> Name -> DecsQ
deriveParents parentNames childName = do
  ds <- mapM (\n -> deriveParent n childName) parentNames
  return . concat $ ds
