module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Model exposing (..)
import Api
import Task
import Http
import Material
import Material.Button as Button
import Material.Scheme
import Material.Color as Color
import Material.Card as Card
import Material.Options as Options exposing (css, when)
import Material.Typography as Typography
import Material.Layout as Layout
import Material.Helpers exposing (lift)
import Material.Grid exposing (grid, cell, size, offset, Device(..))


type alias Model =
    { posts : Maybe (List Post)
    , mdl : Material.Model
    }


type Msg
    = HttpFail Http.Error
    | Mdl (Material.Msg Msg)
    | PostsLoaded (List Post)


init : ( Model, Cmd Msg )
init =
    ( { posts = Nothing
      , mdl = Material.model
      }
    , Cmd.batch
        [ loadPosts
        , Material.init Mdl
        ]
    )


loadPosts =
    Task.perform HttpFail PostsLoaded Api.getPosts


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg' ->
            Material.update msg' model

        PostsLoaded posts ->
            ( { model | posts = Just posts }, Cmd.none )

        HttpFail reason ->
            -- Ignore because I cba writing the html for it
            Debug.log (toString reason)
                ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Material.Scheme.topWithScheme Color.Teal Color.Red
        <| Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            ]
            { header = header model
            , drawer = []
            , tabs = ( [], [] )
            , main = [ mainView model ]
            }


header : Model -> List (Html Msg)
header model =
    [ Layout.row []
        [ Layout.title [] [ text "Cool BuildStuff Demo" ]
        , Layout.spacer
        , div []
            [ Layout.navigation []
                [ Layout.link [ Layout.href "http://buildstuff.lt" ]
                    [ div [] [ text "BuildStuff" ] ]
                ]
            ]
        , div [] []
        ]
    ]


mainView : Model -> Html Msg
mainView model =
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
