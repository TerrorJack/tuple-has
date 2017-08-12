{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}

module Data.Tuple.Has where

import Data.Tuple.Has.Internal

class Has s a where
  field :: Functor f => (a -> f a) -> s -> f s

$(genAll)
