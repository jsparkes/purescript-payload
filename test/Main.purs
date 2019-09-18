module Payload.Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff as Aff
import Effect.Class (liftEffect)
import Payload.Examples.Basic.Main as BasicExample
import Payload.Examples.Files.Main as FilesExample
import Payload.Examples.Movies.Main as MoviesExample
import Payload.Test.Integration.Guards as GuardsTest
import Payload.Test.Integration.Query as QueryTest
import Payload.Test.Integration.Routing as RoutingTest
import Payload.Test.Unit.Cookies as CookiesTest
import Payload.Test.Unit.GuardParsing as GuardParsingTest
import Payload.Test.Unit.Params as ParamsTest
import Payload.Test.Unit.QueryParsing as QueryParsingTest
import Payload.Test.Unit.Response as ResponseTest
import Payload.Test.Unit.Trie as TrieTest
import Payload.Test.Unit.Url as UrlTest
import Payload.Test.Unit.UrlParsing as UrlParsingTest
import Test.Unit (TestSuite)
import Test.Unit.Main (runTest)

tests :: TestSuite
tests = do
  UrlParsingTest.tests
  UrlTest.tests
  QueryParsingTest.tests
  ParamsTest.tests
  TrieTest.tests
  GuardParsingTest.tests
  CookiesTest.tests
  ResponseTest.tests
  RoutingTest.tests

main :: Effect Unit
main = Aff.launchAff_ $ do
  liftEffect $ runTest tests
  GuardsTest.runTests
  QueryTest.runTests
  FilesExample.runTests
  BasicExample.runTests
  MoviesExample.runTests
