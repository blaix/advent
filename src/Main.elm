module Main exposing (main)

import Browser
import Day01.Part1
import Day01.Part2
import Element exposing (column, layout, link, padding, row, spacing, text)
import Element.Events exposing (onClick)
import Element.Input as Input
import Html exposing (Html)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Solver =
    String -> Int


type alias Model =
    { input : String
    , solver : Solver
    }


type Msg
    = InputChanged String
    | SolverChanged Solver


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

        SolverChanged newSolver ->
            { model | solver = newSolver }


view : Model -> Html Msg
view model =
    let
        answer =
            model.solver model.input
                |> String.fromInt
    in
    layout [ padding 10 ] <|
        row
            [ spacing 10 ]
            [ Input.multiline []
                { spellcheck = False
                , onChange = InputChanged
                , text = model.input
                , placeholder = Nothing
                , label = Input.labelAbove [] <| text "Input"
                }
            , text answer
            , column []
                [ link [ onClick (SolverChanged Day01.Part1.answer) ]
                    { url = "#"
                    , label = text "Day 1 - Part 1"
                    }
                , link [ onClick (SolverChanged Day01.Part2.answer) ]
                    { url = "#"
                    , label = text "Day 1 - Part 2"
                    }
                ]
            ]
