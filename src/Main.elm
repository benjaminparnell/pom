module Main exposing (..)

import Html exposing (Html, div, text, button, h1)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import String exposing (padLeft)
import Keyboard
import Time exposing (Time, every, second)
import Constants exposing (r, space)
import Models exposing (Model, initialModel)
import Ports exposing (playSound)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


type Msg
    = KeyMsg Keyboard.KeyCode
    | Tick Time
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyMsg code ->
            if code == space then
                ( { model | active = not model.active }, Cmd.none )
            else if code == r then
                ( initialModel, Cmd.none )
            else
                ( model, Cmd.none )

        Tick interval ->
            if model.active then
                if model.remaining > 0 then
                    ( { model | remaining = model.remaining - 1 }, Cmd.none )
                else
                    ( { model | active = False }, playSound "end" )
            else
                ( model, Cmd.none )

        Reset ->
            ( initialModel, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "max-width-4 mx-auto" ]
        [ div [ class "timer clearfix center" ]
            [ h1 [] [ text ((toString (floor ((toFloat model.remaining) / 60))) ++ ":" ++ (padLeft 2 '0' (toString (model.remaining % 60)))) ]
            , button [ onClick Reset ] [ text "Reset" ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyMsg
        , every second Tick
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
