module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Model exposing (..)
import Api
import Task
import Http


type alias Model =
    { posts : Maybe (List Post)
    }


type Msg
    = HttpFail Http.Error
    | PostsLoaded (List Post)


init : ( Model, Cmd Msg )
init =
    ( { posts = Nothing
      }
    , loadPosts
    )


loadPosts =
    Task.perform HttpFail PostsLoaded Api.getPosts


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PostsLoaded posts ->
            ( { model | posts = Just posts }, Cmd.none )

        HttpFail reason ->
            -- Ignore because I cba writing the html for it
            Debug.log (toString reason)
                ( model, Cmd.none )


view : Model -> Html msg
view model =
    case model.posts of
        Nothing ->
            p [] [ text "Loading.." ]

        Just posts ->
            div [] <| List.map viewPost posts


viewPost : Post -> Html msg
viewPost post =
    div []
        [ h5 [] [ text post.title ]
        , p [] [ text post.body ]
        ]


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
