{-# LANGUAGE TemplateHaskell #-}

module Data.Tuple.Has.Internal where

import Data.Foldable
import GHC.Exts
import Language.Haskell.TH

genHas :: Int -> [Dec]
genHas n =
  let names = [mkName $ "a" ++ show i | i <- [1 .. n]]
      tup_ty = foldl' AppT (TupleT n) (map VarT names)
      tup_exp = foldl' AppE (ConE $ tupleDataName n) (map VarE names)
      fn = mkName "f"
      field_pats = [VarP fn, TupP $ map VarP names]
  in [ InstanceD
       Nothing
       []
       (AppT (AppT (ConT $ mkName "Has") tup_ty) (VarT i))
       [ FunD
           (mkName "field")
           [ Clause
               field_pats
               (NormalB
                  (AppE
                     (AppE (VarE 'fmap) (LamE [VarP i] tup_exp))
                     (AppE (VarE fn) (VarE i))))
               []
           ]
       ]
     | i <- names
     ]

genAll :: Q [Dec]
genAll = pure $ concat [genHas n | n <- [2 .. maxTupleSize]]
