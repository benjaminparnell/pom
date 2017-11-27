module Main exposing (..)

import Html exposing (Html, div, text, button, h1)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Keyboard
import Time exposing (Time, every, second)
import Constants exposing (r, space, pomTime, fiveMinutes, tenMinutes)
import Models exposing (Model, initialModel, getTimeRemaining)
import Ports exposing (playSound, title)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


type Msg
    = KeyMsg Keyboard.KeyCode
    | Tick Time
    | NewInterval Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyMsg code ->
            if code == space then
                ( { model | active = not model.active }, Cmd.none )
            else if code == r then
                ( { model | remaining = model.selectedTime, active = False }, title "pom" )
            else
                ( model, Cmd.none )

        Tick interval ->
            if model.active then
                if model.remaining > 0 then
                    ( { model | remaining = model.remaining - 1 }, title (getTimeRemaining model) )
                else
                    ( { model | active = False }, playSound "end" )
            else
                ( model, Cmd.none )

        NewInterval interval ->
            ( { model | remaining = interval, selectedTime = interval }, title "pom" )


view : Model -> Html Msg
view model =
    div [ class "max-width-4 mx-auto" ]
        [ div [ class "timer clearfix center" ]
            [ h1 [] [ text (getTimeRemaining model) ]
            , div [ class "btn-group" ]
                [ button [ onClick (NewInterval pomTime) ] [ text "25" ]
                , button [ onClick (NewInterval tenMinutes) ] [ text "10" ]
                , button [ onClick (NewInterval fiveMinutes) ] [ text "5" ]
                ]
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
