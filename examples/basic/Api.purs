module Payload.Examples.Basic.Api where

import Data.List (List)
import Data.Symbol (SProxy(..))
import Node.HTTP as HTTP
import Payload.GuardParsing (type (:), GuardTypes(..), Guards(..), Nil)
import Payload.Handlers (File)
import Payload.Route (DELETE, GET, POST, Route(..))
import Payload.Routing (API(..), Routes(..))
import Type.Proxy (Proxy(..))

type User =
  { id :: Int
  , name :: String }

type Post =
  { id :: String
  , text :: String }

newtype AdminUser = AdminUser
  { id :: Int
  , name :: String }

api :: API {
  guards ::
    { adminUser :: AdminUser
    , request :: HTTP.Request },
  routes ::
    { getUsers :: GET "/users"
        { guards :: Guards ("adminUser" : "request" : Nil)
        , response :: Array User }
    , getUsersNonAdmin :: GET "/<name>"
        { params :: { name :: String }
        , response :: Array User }
    , getUser :: GET "/users/<id>"
        { params :: { id :: Int }
        , response :: User }
    , getUsersProfiles :: GET "/users/profiles"
        { response :: Array String }
    , createUser :: POST "/users/new"
        { body :: User
        , guards :: Guards ("adminUser" : Nil)
        , response :: User }
    , getUserPost :: GET "/users/<id>/posts/<postId>"
        { params :: { id :: Int, postId :: String }
        , response :: Post }
    , indexPage :: GET "/"
        { response :: File }
    , files :: GET "/<..path>"
        { params :: { path :: List String }
        , response :: File }
    , getPage :: GET "/pages/<id>"
        { params :: { id :: String }
        , response :: String }
    , getPageMetadata :: GET "/pages/<id>/metadata"
        { params :: { id :: String }
        , response :: String }
    , getHello :: GET "/hello there"
        { response :: String }
  }
}
api = API

apiStructured :: API {
  guards :: {
     adminUser :: AdminUser,
     request :: HTTP.Request
  },
  routes :: {
    users :: Routes "/users" {
      getUsersProfiles :: GET "/profiles" {
        response :: Array String
      },
      userById :: Routes "/<id>" {
        params :: { id :: Int },
        getUser :: GET "/" {
          response :: User
        },
        getUserPost :: GET "/posts/<postId>" {
          params :: { postId :: String },
          response :: Post
        }
      }
    },
    adminUsers :: Routes "/users" {
      guards :: Guards ("adminUser" : Nil),
      getUsers :: GET "/" {
        guards :: Guards ("request" : Nil),
        response :: Array User
      },
      createUser :: POST "/new" {
        body :: User,
        response :: User
      }
    },
    getUsersNonAdmin :: GET "/<name>" {
      params :: { name :: String },
      response :: Array User
    },
    indexPage :: GET "/" {
      response :: File
    },
    files :: GET "/<..path>" {
      params :: { path :: List String },
      response :: File
    },
    getPage :: GET "/pages/<id>" {
      params :: { id :: String },
      response :: String
    },
    getPageMetadata :: GET "/pages/<id>/metadata" {
      params :: { id :: String },
      response :: String
    },
    getHello :: GET "/hello there" {
      response :: String
    }
  }
}
apiStructured = API