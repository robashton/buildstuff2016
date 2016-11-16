module Api
    exposing
        ( getPosts
        )

--http://jsonplaceholder.typicode.com/post

import Task
import Http
import Model exposing (..)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (required, decode, optional)


getPosts : Platform.Task Http.Error (List Post)
getPosts =
    Http.get (list decodePost) "http://jsonplaceholder.typicode.com/posts"


decodePost : Json.Decoder Post
decodePost =
    decode Post
        |> required "userId" int
        |> required "id" int
        |> required "title" string
        |> required "body" string
