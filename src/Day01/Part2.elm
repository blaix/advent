module Day01.Part2 exposing (..)

import Day01.Part1
    exposing
        ( Measurement
        , countIncreases
        , getDepthChanges
        , getMeasurements
        , pairWithNextMeasurement
        )
import Html exposing (Html, text)


main : Html msg
main =
    text (Debug.toString answer)


answer : Int
answer =
    input
        |> getMeasurements
        |> sumTriplets
        |> pairWithNextMeasurement
        |> getDepthChanges
        |> countIncreases


sumTriplets : List Measurement -> List Measurement
sumTriplets measurements =
    measurements
        |> getTriplets
        |> List.map List.sum


getTriplets : List Measurement -> List (List Measurement)
getTriplets measurements =
    let
        offset1 =
            List.drop 1 measurements

        offset2 =
            List.drop 2 measurements
    in
    List.map3 (\x y z -> [ x, y, z ]) measurements offset1 offset2



-- Sample input for now


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
