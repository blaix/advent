module Main exposing (main)

import Browser
import Day01
import Element
    exposing
        ( Element
        , centerX
        , column
        , el
        , fill
        , layout
        , link
        , padding
        , row
        , spacing
        , text
        , width
        )
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


init : Model
init =
    { input = Day01.input
    , solver = Day01.part1
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
            [ spacing 10
            , width fill
            ]
            [ column [ width fill ] <|
                inputView model.input
            , column [ width fill ] <|
                answerView answer
            , column []
                navigationView
            ]


inputView : String -> List (Element Msg)
inputView input =
    [ Input.multiline []
        { spellcheck = False
        , onChange = InputChanged
        , text = input
        , placeholder = Nothing
        , label = Input.labelAbove [] <| text "Input"
        }
    ]


answerView : String -> List (Element Msg)
answerView answer =
    [ el [ centerX ] (text answer) ]


navigationView : List (Element Msg)
navigationView =
    [ link [ onClick (SolverChanged Day01.part1) ]
        { url = "#"
        , label = text "Day 1 - Part 1"
        }
    , link [ onClick (SolverChanged Day01.part2) ]
        { url = "#"
        , label = text "Day 1 - Part 2"
        }
    ]
