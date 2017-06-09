module Main exposing (..)

import Html as App
import Html exposing (..)
import Html.Events exposing (..)
import Http
import Api
import Task
import Model exposing (..)
import Maybe


type alias Model =
    { x : Int
    , posts : Maybe (List Post)
    }


type Msg
    = IncreaseMyNumberYo
    | GetPostsResponse (Result Http.Error (List Post))


init : ( Model, Cmd Msg )
init =
    ( { x = 5
      , posts = Nothing
      }
    , getPosts
    )


getPosts =
    Http.send GetPostsResponse Api.getPosts


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncreaseMyNumberYo ->
            ( { model | x = model.x + 1 }, Cmd.none )

        GetPostsResponse result ->
            case result of
                Ok posts ->
                    ( { model | posts = Just posts }, Cmd.none )

                Err _ ->
                    -- Sssh ignore it like a simple JS developer would
                    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text <| "My Number is " ++ (toString model.x) ]
        , button [ onClick IncreaseMyNumberYo ] [ text "Click me!" ]
        , (case model.posts of
            Nothing ->
                p [] [ text "Loading..." ]

            Just posts ->
                div [] <| List.map postView posts
          )
        ]


postView : Post -> Html msg
postView post =
    div []
        [ h2 [] [ text post.title ]
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
