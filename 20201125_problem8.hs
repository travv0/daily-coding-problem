-- A unival tree (which stands for "universal value") is a tree where all nodes
-- under it have the same value.
--
-- Given the root to a binary tree, count the number of unival subtrees.
--
-- For example, the following tree has 5 unival subtrees:
--
--    0
--   / \
--  1   0
--     / \
--    1   0
--   / \
--  1   1

module Main where

import Control.Exception (assert)

data Tree a = Leaf a | Tree a (Tree a) (Tree a)

val :: Tree a -> a
val (Leaf a) = a
val (Tree a _ _) = a

isUnivalTree :: (Eq a) => Tree a -> Bool
isUnivalTree (Leaf _) = True
isUnivalTree (Tree v a b) =
    v == val a && v == val b
        && isUnivalTree a
        && isUnivalTree b

countUnivalSubtrees :: (Eq a) => Tree a -> Int
countUnivalSubtrees (Leaf _) = 1
countUnivalSubtrees tree@(Tree _ a b) =
    ( if isUnivalTree tree
        then 1
        else 0
    )
        + countUnivalSubtrees a
        + countUnivalSubtrees b

main :: IO ()
main =
    let tree = Tree 0 (Leaf 1) (Tree 0 (Tree 1 (Leaf 1) (Leaf 1)) (Leaf 0))
        univalCount = countUnivalSubtrees tree
     in print $ assert (univalCount == 5) univalCount