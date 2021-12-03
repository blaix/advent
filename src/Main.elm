module Main exposing (main)

import Browser
import Day01.Part1
import Html exposing (Html, div, p, text, textarea)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { input : String
    , solver : String -> Int
    }


type Msg
    = InputChanged String


sampleInput : String
sampleInput =
    """
199
200
208
210
200
207
240
269
260
263
"""


init : Model
init =
    { input = sampleInput
    , solver = Day01.Part1.answer
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        InputChanged newInput ->
            { model | input = newInput }


view : Model -> Html Msg
view model =
    let
        answer =
            model.solver model.input
                |> String.fromInt
    in
    div []
        [ textarea
            [ onInput InputChanged ]
            [ text model.input ]
        , p [] [ text answer ]
        ]
