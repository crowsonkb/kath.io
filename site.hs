#!/usr/bin/env runhaskell

{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Text.Pandoc

wOptions :: WriterOptions
wOptions = defaultHakyllWriterOptions { writerEmailObfuscation = NoObfuscation,
                                        writerHtml5 = True }

myCompiler :: Compiler (Item String)
myCompiler = pandocCompilerWith defaultHakyllReaderOptions wOptions

copy :: Rules ()
copy = route idRoute >> compile copyFileCompiler

main :: IO ()
main = hakyll $ do
    -- Static files
    match "images/*" copy
    match "js/*" copy

    -- CSS
    match "css/*" $ route idRoute >> compile compressCssCompiler

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
