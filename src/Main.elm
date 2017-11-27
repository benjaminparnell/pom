module Main exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Keyboard
import Time exposing (Time, every, second)


type alias Model =
    { active : Bool
    , remaining : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model False 5, Cmd.none )


type Msg
    = KeyMsg Keyboard.KeyCode
    | Tick Time
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyMsg code ->
            if code == 32 then
                ( { model | active = not model.active }, Cmd.none )
            else if code == 82 then
                ( { model | active = False, remaining = 10 }, Cmd.none )
            else
                ( model, Cmd.none )

        Tick interval ->
            if model.active then
                if model.remaining > 0 then
                    ( { model | remaining = model.remaining - 1 }, Cmd.none )
                else
                    ( { model | active = False }, Cmd.none )
            else
                ( model, Cmd.none )

        Reset ->
            ( { model | remaining = 100 }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text ((toString model.active) ++ "-" ++ (toString model.remaining))
        , text
            (if model.remaining == 0 then
                "Done"
             else
                ""
            )
        , button [ onClick Reset ] [ text "Reset" ]
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
