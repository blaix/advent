module Main exposing (main)

import Browser
import Day01
import Day02
import Element
    exposing
        ( Attribute
        , Element
        , alignRight
        , alignTop
        , column
        , el
        , fill
        , focusStyle
        , height
        , layoutWith
        , link
        , padding
        , paddingEach
        , paddingXY
        , px
        , rgb255
        , row
        , spacing
        , text
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
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
    String -> String


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
    in
    layoutWith
        { options =
            [ focusStyle
                { borderColor = Nothing
                , backgroundColor = Nothing
                , shadow = Nothing
                }
            ]
        }
        [ Background.color colors.black
        , Font.color colors.silver
        ]
    <|
        row
            [ width fill, spacing 30, height fill ]
            [ el [] Element.none
            , column [ paddingXY 0 10, alignTop, width fill, height fill ] <|
                inputView model.input
            , column [ paddingXY 0 10, alignTop, width fill, height fill ] <|
                answerView answer
            , column [ alignTop, alignRight ]
                navigationView
            ]


inputView : String -> List (Element Msg)
inputView input =
    [ el [ width fill ] <|
        Input.multiline
            [ Background.color colors.green
            , Border.width 1
            , height (px 500)
            ]
            { spellcheck = False
            , onChange = InputChanged
            , text = input
            , placeholder = Nothing
            , label = Input.labelAbove [] <| text "Input"
            }
    ]


answerView : String -> List (Element Msg)
answerView answer =
    [ el [ paddingEach { top = 0, left = 0, right = 0, bottom = 6 } ]
        (text "Answer")
    , el
        [ padding 20
        , Border.width 4
        , Border.rounded 3
        , Background.color colors.red
        , Font.size 30
        ]
        (text answer)
    ]


navigationView : List (Element Msg)
navigationView =
    -- TODO: persistent links and active highlight
    [ el (navAttrs []) (text "-- Day 1 --")
    , link (navAttrs [ onClick (InputChanged Day01.input) ])
        { url = "#"
        , label = text "Sample Input"
        }
    , link (navAttrs [ onClick (SolverChanged Day01.part1) ])
        { url = "#"
        , label = text "Solve Part 1"
        }
    , link (navAttrs [ onClick (SolverChanged Day01.part2) ])
        { url = "#"
        , label = text "Solve Part 2"
        }
    , el (navAttrs []) (text "-- Day 2 --")
    , link (navAttrs [ onClick (InputChanged Day02.input) ])
        { url = "#"
        , label = text "Sample Input"
        }
    , link (navAttrs [ onClick (SolverChanged Day02.part1) ])
        { url = "#"
        , label = text "Solve Part 1"
        }
    , link (navAttrs [ onClick (SolverChanged Day02.part2) ])
        { url = "#"
        , label = text "Solve Part 2"
        }
    ]


navAttrs : List (Attribute Msg) -> List (Attribute Msg)
navAttrs additionalAttrs =
    additionalAttrs
        ++ [ padding 10
           , width fill
           , Background.color colors.brown
           , Border.widthEach
                { top = 0
                , left = 1
                , right = 0
                , bottom = 1
                }
           ]


colors :
    { red : Element.Color
    , green : Element.Color
    , silver : Element.Color
    , black : Element.Color
    , brown : Element.Color
    }
colors =
    { red = rgb255 133 1 11
    , green = rgb255 34 81 64
    , silver = rgb255 170 170 170
    , black = rgb255 30 30 30
    , brown = rgb255 130 81 40
    }
