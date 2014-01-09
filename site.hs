{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Text.Pandoc

myWriterOptions :: WriterOptions
myWriterOptions = defaultHakyllWriterOptions { writerHtml5 = True }

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

    -- Markdown error pages
    match "error/*.md" $ do
    route $ setExtension "html"
    compile $ pandocCompilerWith defaultHakyllReaderOptions myWriterOptions
        >>= loadAndApplyTemplate "templates/default.html" defaultContext

    -- Markdown content
    match ("**.md" .&&. complement "README.md") $ do
    route $ setExtension "html"
    compile $ pandocCompilerWith defaultHakyllReaderOptions myWriterOptions
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls
