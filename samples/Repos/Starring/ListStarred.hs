module ListStarred where

import qualified Github.Repos.Starring as Github
import Data.List (intercalate)
import Data.Maybe (fromMaybe)

main = do
  possibleRepos <- Github.reposStarredBy Nothing "mike-burns"
  putStrLn $ either (("Error: "++) . show)
                    (intercalate "\n\n" . map formatRepo)
                    possibleRepos

formatRepo repo =
  (Github.repoName repo) ++ "\t" ++
    (fromMaybe "" $ Github.repoDescription repo) ++ "\n" ++
    (Github.repoHtmlUrl repo) ++ "\n" ++
    (Github.repoCloneUrl repo) ++ "\t" ++
    (formatDate $ Github.repoUpdatedAt repo) ++ "\n" ++
    formatLanguage (Github.repoLanguage repo)

formatDate = show . Github.fromGithubDate

formatLanguage (Just language) = "language: " ++ language ++ "\t"
formatLanguage Nothing = ""
