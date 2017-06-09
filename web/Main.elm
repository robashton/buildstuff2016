module Main exposing (..)

import Html as App
import Html exposing (..)
import Html.Events exposing (..)
import Http
import Task
import Model exposing (..)
import Maybe


type alias Model =
    {}


type Msg
    = None


init : ( Model, Cmd Msg )
init =
    ( {}
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        []


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
