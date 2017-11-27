module Models exposing (..)

import Constants exposing (pomTime)
import String exposing (padLeft)


type alias Model =
    { active : Bool
    , remaining : Int
    , selectedTime : Int
    }


initialModel : Model
initialModel =
    { active = False
    , remaining = pomTime
    , selectedTime = pomTime
    }


getTimeRemaining : Model -> String
getTimeRemaining model =
    (toString ((floor ((toFloat model.remaining) / 60)))) ++ ":" ++ (padLeft 2 '0' (toString (model.remaining % 60)))
