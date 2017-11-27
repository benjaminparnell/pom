module Models exposing (..)

import Constants exposing (pomTimeInSeconds)


type alias Model =
    { active : Bool
    , remaining : Int
    }


initialModel : Model
initialModel =
    { active = False
    , remaining = pomTimeInSeconds
    }
