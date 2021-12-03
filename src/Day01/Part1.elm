module Day01.Part1 exposing (..)

import Html exposing (Html, text)


main : Html msg
main =
    text (Debug.toString (answer input))


answer : String -> Int
answer rawInput =
    rawInput
        |> getMeasurements
        |> pairWithNextMeasurement
        |> getDepthChanges
        |> countIncreases


type DepthChange
    = Increase
    | Decrease
    | NoChange


type alias Measurement =
    Int


getMeasurements : String -> List Measurement
getMeasurements rawInput =
    rawInput
        |> String.trim
        |> String.lines
        |> List.filterMap String.toInt


pairWithNextMeasurement : List Measurement -> List ( Measurement, Measurement )
pairWithNextMeasurement measurements =
    let
        offsetMeasurements =
            List.drop 1 measurements
    in
    List.map2 Tuple.pair measurements offsetMeasurements


getDepthChanges : List ( Measurement, Measurement ) -> List DepthChange
getDepthChanges pairedMeasurements =
    List.map toDepthChange pairedMeasurements


toDepthChange : ( Measurement, Measurement ) -> DepthChange
toDepthChange ( m1, m2 ) =
    if m1 < m2 then
        Increase

    else if m1 > m2 then
        Decrease

    else
        NoChange


countIncreases : List DepthChange -> Int
countIncreases depthChanges =
    List.filter (\x -> x == Increase) depthChanges
        |> List.length



-- Sample input for now.


input : String
input =
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
