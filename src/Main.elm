module Main exposing (main)

import Browser
import Day01.Part1
import Day01.Part2
import Html exposing (Html, a, div, li, p, text, textarea, ul)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick, onInput)


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
    div []
        [ textarea
            [ onInput InputChanged ]
            [ text model.input ]
        , p [] [ text answer ]
        , ul []
            [ li []
                -- TODO: persistent urls
                [ a [ href "#", onClick (SolverChanged Day01.Part1.answer) ]
                    [ text "Day 1 - Part 1" ]
                ]
            , li []
                [ a [ href "#", onClick (SolverChanged Day01.Part2.answer) ]
                    [ text "Day 1 - Part 2" ]
                ]
            ]
        ]
