module Main exposing (main)

import Browser
import Day01
import Element
    exposing
        ( Attribute
        , Element
        , alignRight
        , alignTop
        , centerX
        , column
        , el
        , fill
        , layout
        , link
        , padding
        , paddingXY
        , row
        , shrink
        , text
        , width
        )
import Element.Border as Border
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
    layout [] <|
        row
            [ width fill ]
            [ column [ padding 10, width fill ] <|
                inputView model.input
            , column [ paddingXY 10 50, alignTop, width fill ] <|
                answerView answer
            , column [ alignTop, alignRight ]
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
    [ el [ centerX, width shrink, padding 10, Border.width 5 ] (text answer) ]


navigationView : List (Element Msg)
navigationView =
    -- TODO: persistent links and active highlight
    [ navLink [ onClick (SolverChanged Day01.part1) ]
        { url = "#"
        , label = text "Day 1 - Part 1"
        }
    , navLink [ onClick (SolverChanged Day01.part2) ]
        { url = "#"
        , label = text "Day 1 - Part 2"
        }
    ]


navLink :
    List (Attribute Msg)
    -> { url : String, label : Element Msg }
    -> Element Msg
navLink attributes values =
    let
        allAttrs =
            attributes
                ++ [ padding 10
                   , Border.widthEach
                        { top = 0
                        , left = 1
                        , right = 0
                        , bottom = 1
                        }
                   ]
    in
    link allAttrs values
