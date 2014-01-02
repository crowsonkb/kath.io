{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Text.Pandoc

myWriterOptions :: WriterOptions
myWriterOptions = defaultHakyllWriterOptions { writerHtml5 = True }

defaultRules :: Rules ()
defaultRules = do
    route $ setExtension "html"
    compile $ pandocCompilerWith defaultHakyllReaderOptions myWriterOptions
        >>= loadAndApplyTemplate "templates/default.html" defaultContext            
        >>= relativizeUrls

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "templates/*" $ compile templateCompiler

    match ("**.md" .&&. complement "README.md") $ defaultRules
