-- Suppose we represent our file system by a string in the following manner:
--
-- The string "dir\n\tsubdir1\n\tsubdir2\n\t\tfile.ext" represents:
--
-- dir
--     subdir1
--     subdir2
--         file.ext
--
-- The directory dir contains an empty sub-directory subdir1 and a sub-directory
-- subdir2 containing a file file.ext.
--
-- The string
-- "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
-- represents:
--
-- dir
--     subdir1
--         file1.ext
--         subsubdir1
--     subdir2
--         subsubdir2
--             file2.ext
--
-- The directory dir contains two sub-directories subdir1 and subdir2. subdir1
-- contains a file file1.ext and an empty second-level sub-directory subsubdir1.
-- subdir2 contains a second-level sub-directory subsubdir2 containing a file
-- file2.ext.
--
-- We are interested in finding the longest (number of characters) absolute path
-- to a file within our file system. For example, in the second example above,
-- the longest absolute path is "dir/subdir2/subsubdir2/file2.ext", and its
-- length is 32 (not including the double quotes).
--
-- Given a string representing the file system in the above format, return the
-- length of the longest absolute path to a file in the abstracted file system.
-- If there is no file in the system, return 0.
--
-- Note:
--
-- The name of a file contains at least a period and an extension.
--
-- The name of a directory or sub-directory will not contain a period.

module Main where

import Control.Exception (assert)
import Data.List (elemIndex, findIndex)

data File = Dir String [File] | File String
    deriving (Show)

main :: IO ()
main = do
    assert
        ( longestAbsPath (parseFileSystem "dir\n\tsubdir1\n\tsubdir2\n\t\tfile.ext")
            == "dir/subdir2/file.ext"
        )
        $ putStrLn "got dir/subdir2/file.ext"

    assert
        ( longestAbsPath
            ( parseFileSystem "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
            )
            == "dir/subdir2/subsubdir2/file2.ext"
        )
        $ putStrLn "got dir/subdir2/subsubdir2/file2.ext"

longestAbsPath :: [File] -> String
longestAbsPath [] = ""
longestAbsPath [File fileName] = fileName
longestAbsPath [Dir dirName files] = dirName ++ "/" ++ longestAbsPath files
longestAbsPath (file : rest)
    | length (longestAbsPath [file]) > length (longestAbsPath rest) = longestAbsPath [file]
    | otherwise = longestAbsPath rest

splitWithDepth :: String -> [(Int, String)]
splitWithDepth = map addDepth . split '\n'
  where
    addDepth part = case findIndex (/= '\t') part of
        Just index -> (index, drop index part)
        Nothing -> (0, part)

split :: Eq a => a -> [a] -> [[a]]
split x xs = case elemIndex x xs of
    Just index ->
        let (first, _ : rest) = splitAt index xs
         in first : split x rest
    Nothing -> [xs]

parseFileSystem :: String -> [File]
parseFileSystem = concatMap makeFiles . splitSubDirs . splitWithDepth
  where
    makeFiles :: [(Int, String)] -> [File]
    makeFiles [] = []
    makeFiles ((_, part) : parts) =
        let nextParts = splitSubDirs parts
         in [ if '.' `elem` part
                then File part
                else Dir part $ concatMap makeFiles nextParts
            ]

splitSubDirs :: [(Int, String)] -> [[(Int, String)]]
splitSubDirs [] = []
splitSubDirs [part] = [[part]]
splitSubDirs allParts@((depth, _) : parts) = case findIndex ((== depth) . fst) parts of
    Just index ->
        let (first, rest) = splitAt (index + 1) allParts
         in first : splitSubDirs rest
    Nothing -> [allParts]
