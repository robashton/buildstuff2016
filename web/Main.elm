module Main exposing (..)

import Html.App as App


type Model
    = ModelNotImplemented


type Msg
    = MsgNotImplemented


init : ( Model, Cmd Msg )
init =
    ( ModelNotImplemented
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgNotImplemented ->
            ( model, Cmd.none )


view : Model -> Html msg
view model =
    p [] [ text "Hello World" ]

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
