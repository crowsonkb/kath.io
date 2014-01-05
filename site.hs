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
    -- Static files
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "js/*" $ do
        route   idRoute
        compile copyFileCompiler

    -- CSS
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- Templates
    match "templates/*" $ compile templateCompiler

    -- Markdown
    match ("**.md" .&&. complement "README.md") $ defaultRules
