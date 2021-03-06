{-# LANGUAGE DeriveDataTypeable #-}
module Test.Hspec.CompatSpec (main, spec) where

import           Helper
import           System.SetEnv
import           Data.Typeable

data SomeType = SomeType
  deriving Typeable

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "showType" $ do
    it "shows unqualified name of type" $ do
      showType SomeType `shouldBe` "SomeType"

  describe "showFullType (currently unused)" $ do
    it "shows fully qualified name of type" $ do
      showFullType SomeType `shouldBe` "Test.Hspec.CompatSpec.SomeType"

  describe "lookupEnv" $ do
    it "returns value of specified environment variable" $ do
      setEnv "FOO" "bar"
      lookupEnv "FOO" `shouldReturn` Just "bar"

    it "returns Nothing if specified environment variable is not set" $ do
      unsetEnv "FOO"
      lookupEnv "FOO" `shouldReturn` Nothing
