{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Text.Pandoc

myCompiler :: Compiler (Item String)
myCompiler = pandocCompilerWith defaultHakyllReaderOptions myWriterOptions
    where myWriterOptions = defaultHakyllWriterOptions { writerHtml5 = True }

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
        route   $ setExtension "html"
        compile $ myCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext

    -- Markdown content
    match ("**.md" .&&. complement "README.md") $ do
        route   $ setExtension "html"
        compile $ myCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls
