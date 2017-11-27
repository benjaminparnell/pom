module Models exposing (..)

import Constants exposing (pomTime)


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
